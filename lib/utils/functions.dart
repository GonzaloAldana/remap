import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models.dart';

Future<Marcador> getMarcador(String coleccion, String id) async {
  DocumentSnapshot doc =
      await Firestore.instance.collection(coleccion).document(id).get();
  return Marcador.fromMap(doc.data, doc.documentID);
}

Future<List<Marcador>> getMarcadores(String coleccion) async {
  List<Marcador> lista = List();
  QuerySnapshot doc =
      await Firestore.instance.collection(coleccion).getDocuments();
  lista = doc.documents.map((DocumentSnapshot docSnapshot) {
    return Marcador.fromMap(docSnapshot.data, docSnapshot.documentID);
  }).toList();
  return lista;
}

void launchMap(String lat, String long) async {
  var mapSchema = 'geo:$lat,$long?z=23&q=$lat,$long';
  if (Platform.isIOS) mapSchema = 'https://maps.apple.com/?q=$lat,$long';
  if (await canLaunch(mapSchema)) {
    await launch(mapSchema);
  } else {
    throw 'Could not launch $mapSchema';
  }
}

Future<String> dist(
    double latInit, double lonInit, double lat, double lon) async {
  double distancia =
      await Geolocator().distanceBetween(latInit, lonInit, lat, lon);
  distancia = distancia / 1000;
  return distancia.toStringAsFixed(2);
}

Future<List<DistanciaMarcador>> getDistanciasMarcadores(
    List<Marcador> marcadores, double latInit, double lonInit) async {
  List<DistanciaMarcador> resultado = List<DistanciaMarcador>();
  for (Marcador marcador in marcadores) {
    DistanciaMarcador distanciaMarcador = DistanciaMarcador();
    distanciaMarcador.marcador = marcador;
    distanciaMarcador.distancia =
        await dist(latInit, lonInit, marcador.lat, marcador.lon);
    resultado.add(distanciaMarcador);
  }
  return resultado;
}

Future<Position> getPosition() async {
  Position respuesta = await Geolocator().getLastKnownPosition();
  await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) {
    respuesta = position;
  });
  return respuesta;
}

List<List<DistanciaMarcador>>
    listaRecursivaCombinacionesTiendasCumplenConElCliente;
Future<List<DistanciaMarcador>> getSmartTicket(String collection, double dist,
    List<bool> products, List<bool> services) async {
  /// Aquí está la magia ;)
  /// Por Gonzalo Aldana
  /// gonzaloaldana.com

  listaRecursivaCombinacionesTiendasCumplenConElCliente =
      List<List<DistanciaMarcador>>();
  Position posicionUsuario = await getPosition();
  List<Marcador> marcadores = await getMarcadores(collection);
  List<DistanciaMarcador> distanciaMarcadores = await getDistanciasMarcadores(
      marcadores, posicionUsuario.latitude, posicionUsuario.longitude);
  List<DistanciaMarcador> listaCercanosQueCumplenloQueQuiereElCliente =
      List<DistanciaMarcador>();

  distanciaMarcadores
      .removeWhere((item) => double.parse(item.distancia) > dist);

  // Hasta aquí ya tenemos los lugares cercanos
  // Vamos a comprobar que tengan lo que el usuario necesita

  for (DistanciaMarcador distMarc in distanciaMarcadores) {
    int necesarios = 0;

    for (var i = 0; i < products.length; i++) {
      if (distMarc.marcador.productos[i] && products[i]) necesarios++;
    }

    for (var i = 0; i < services.length; i++) {
      if (distMarc.marcador.servicios[i] && services[i]) necesarios++;
    }
    if (necesarios > 0) {
      listaCercanosQueCumplenloQueQuiereElCliente.add(distMarc);
    }
  }
  ;

  // Hasta aquí ya tenemos los lugares cercanos con lo que el cliente necesita;
  // necesitamos ver las permutaciones para conocer todas las combinaciones que funcionen
  // Para esto vamos a usar recursividad

  for (DistanciaMarcador distMarc
      in listaCercanosQueCumplenloQueQuiereElCliente) {
    // Vamos a comenzar nuestras combinaciones con cada elemento de la lista
    List<DistanciaMarcador> listaFaltantes =
        List.from(listaCercanosQueCumplenloQueQuiereElCliente);
    listaFaltantes.remove(distMarc);
    await getCombinacionRecursiva(List<DistanciaMarcador>(), distMarc, products,
        services, listaFaltantes);
  }
  ;

  // Lista en caso de que no haya suficientes tiendas para surtir la lista de la despensa
  List<DistanciaMarcador> listaDefault = List<DistanciaMarcador>();
  DistanciaMarcador distMarcadorDefault = DistanciaMarcador();
  Marcador marcadorDefault = Marcador();
  marcadorDefault.nombre =
      "No pudimos completar tu ticket; nos falta mapear más tiendas por tu zona";
  marcadorDefault.imagen =
      'https://previews.123rf.com/images/elenabsl/elenabsl1409/elenabsl140900005/31392676-street-map.jpg';
  distMarcadorDefault.marcador = marcadorDefault;
  distMarcadorDefault.distancia = "--";
  listaDefault.add(distMarcadorDefault);

  return listaRecursivaCombinacionesTiendasCumplenConElCliente.isNotEmpty
      ? listaRecursivaCombinacionesTiendasCumplenConElCliente[0]
      : listaDefault;
}

Future<Void> getCombinacionRecursiva(
    List<DistanciaMarcador> listaTemporal,
    DistanciaMarcador marcadorSiguiente,
    List<bool> productosFaltantes,
    List<bool> serviciosFaltantes,
    List<DistanciaMarcador> listaFaltantes) async {
  int necesarios = 0;

  for (var i = 0; i < productosFaltantes.length; i++) {
    if (marcadorSiguiente.marcador.productos[i] && productosFaltantes[i]) {
      necesarios++;
    }
  }

  for (var i = 0; i < serviciosFaltantes.length; i++) {
    if (marcadorSiguiente.marcador.servicios[i] && serviciosFaltantes[i]) {
      necesarios++;
    }
  }

  if (necesarios > 0) {
    print('yeaaa');

    // Marcar este como parte de la permutación
    listaTemporal.add(marcadorSiguiente);

    // Quitar este elemento de la lista de faltantes
    listaFaltantes.remove(marcadorSiguiente);

    // Marcar los servicios que ya cumplimos
    for (var i = 0; i < productosFaltantes.length; i++) {
      if (marcadorSiguiente.marcador.productos[i]) {
        productosFaltantes[i] = false;
      }
    }

    for (var i = 0; i < serviciosFaltantes.length; i++) {
      if (marcadorSiguiente.marcador.servicios[i]) {
        serviciosFaltantes[i] = false;
      }
    }

    // Verificar si ya con esto terminamos de cumplir las necesidades
    int necesariosFaltantes = 0;

    for (var i = 0; i < productosFaltantes.length; i++) {
      if (productosFaltantes[i]) {
        necesariosFaltantes++;
      }
    }

    for (var i = 0; i < serviciosFaltantes.length; i++) {
      if (serviciosFaltantes[i] && serviciosFaltantes[i]) {
        necesariosFaltantes++;
      }
    }

    print(productosFaltantes);
    print(serviciosFaltantes);
    print(necesariosFaltantes);

    // Si aún quedan necesidades por cumplir, vamos recursivamente
    // Si no es el caso, agregamos esta permutación a la lista de los que cumplen con las necesidades del cliente
    if (necesariosFaltantes > 0) {
      for (DistanciaMarcador distMarc in listaFaltantes) {
        // Vamos a repetir la recursividad
        await getCombinacionRecursiva(listaTemporal, distMarc,
            productosFaltantes, serviciosFaltantes, listaFaltantes);
      }
    } else {
      listaRecursivaCombinacionesTiendasCumplenConElCliente.add(listaTemporal);
    }
    ;
  }
}
