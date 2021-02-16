import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models.dart';

Future<Marcador> getMarcador(String coleccion, String id) async {
  var doc =
      await FirebaseFirestore.instance.collection(coleccion).doc(id).get();
  return Marcador.fromMap(doc.data(), doc.id);
}

Future<List<Aliado>> getAliados() async {
  var lista = <Aliado>[];
  var doc = await FirebaseFirestore.instance.collection('aliados').get();
  lista = doc.docs.map((DocumentSnapshot docSnapshot) {
    return Aliado.fromMap(docSnapshot.data());
  }).toList();
  return lista;
}

Future<void> putStatiscticsUpdate(
    String coleccion, DistanciaMarcador distmarc, int option) async {
  /// Option:
  /// 1, vistos
  /// 2, compartidos
  /// 3, contactados
  String campo;
  switch (option) {
    case 1:
      campo = 'vistos';
      break;
    case 2:
      campo = 'compartidos';
      break;
    case 3:
      campo = 'contactados';
      break;
    default:
      campo = 'vistos';
      break;
  }
  await FirebaseFirestore.instance
      .collection(coleccion)
      .doc(distmarc.marcador.id)
      .update({campo: FieldValue.increment(1)});
}

void shareImage(String imageUrl) async {
  var request = await HttpClient().getUrl(Uri.parse(imageUrl));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);
  var tipo = imageUrl.split('.').last.split('%').first.split('?').first;
  await Share.file('Compartir en', 'foto.${tipo}', bytes.buffer.asUint8List(),
      'image/${tipo}',
      text: 'Compartido desde Meica');
}

Future<List<Marcador>> getMarcadores(String coleccion) async {
  var lista = <Marcador>[];
  var doc = await FirebaseFirestore.instance
      .collection(coleccion)
      .where('validado', isEqualTo: true)
      .get();
  lista = doc.docs.map((DocumentSnapshot docSnapshot) {
    return Marcador.fromMap(docSnapshot.data(), docSnapshot.id);
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

void launchWhatsApp(DistanciaMarcador marc) async {
  var message =
      'Hola, vi tu tienda en Meica y me gustaría ponerme en contacto contigo';

  await FlutterOpenWhatsapp.sendSingleMessage(marc.marcador.telefono, message);
}

Future<String> dist(
    double latInit, double lonInit, double lat, double lon) async {
  var distancia = await Geolocator.distanceBetween(latInit, lonInit, lat, lon);
  distancia = distancia / 1000;
  return distancia.toStringAsFixed(2);
}

Future<List<DistanciaMarcador>> getDistanciasMarcadores(
    List<Marcador> marcadores, double latInit, double lonInit) async {
  var resultado = <DistanciaMarcador>[];
  for (var marcador in marcadores) {
    var distanciaMarcador = DistanciaMarcador();
    distanciaMarcador.marcador = marcador;
    distanciaMarcador.distancia =
        await dist(latInit, lonInit, marcador.lat, marcador.lon);
    resultado.add(distanciaMarcador);
  }
  return resultado;
}

Future<Position> getPosition() async {
  var respuesta;
  try {
    respuesta = await Geolocator.getLastKnownPosition();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      respuesta = position;
    });
  } catch (err) {
    respuesta = Position(latitude: 21.1146651, longitude: -101.6485488);
  }
  return respuesta;
}

List<List<DistanciaMarcador>>
    listaRecursivaCombinacionesTiendasCumplenConElCliente;
Future<List<DistanciaMarcador>> getSmartTicket(String collection, double dist,
    List<bool> products, List<DistanciaMarcador> distanciaMarcadores) async {
  /// Aquí está la magia ;)
  /// Por Gonzalo Aldana
  /// gonzaloaldana.com
//TODO: cambiar el área administrativa
  listaRecursivaCombinacionesTiendasCumplenConElCliente =
      <List<DistanciaMarcador>>[];
  var listaCercanosQueCumplenloQueQuiereElCliente = <DistanciaMarcador>[];

  distanciaMarcadores
      .removeWhere((item) => double.parse(item.distancia) > dist);

  // Hasta aquí ya tenemos los lugares cercanos
  // Vamos a comprobar que tengan lo que el usuario necesita

  for (var distMarc in distanciaMarcadores) {
    var necesarios = 0;

    for (var i = 0;
        i < min(distMarc.marcador.productos.length, products.length);
        i++) {
      if (distMarc.marcador.productos[i] && products[i]) {
        necesarios++;
        break;
      }
    }
    if (necesarios > 0) {
      listaCercanosQueCumplenloQueQuiereElCliente.add(distMarc);
    }
  }
  ;

  // Hasta aquí ya tenemos los lugares cercanos con lo que el cliente necesita;
  // necesitamos ver las permutaciones para conocer todas las combinaciones que funcionen
  // Para esto vamos a usar recursividad
  print(listaCercanosQueCumplenloQueQuiereElCliente.length);
  for (var distMarc in listaCercanosQueCumplenloQueQuiereElCliente) {
    // Vamos a comenzar nuestras combinaciones con cada elemento de la lista
    var listaFaltantes = List<DistanciaMarcador>.from(
        listaCercanosQueCumplenloQueQuiereElCliente);
    listaFaltantes.remove(distMarc);
    await getCombinacionRecursiva(
        <DistanciaMarcador>[], distMarc, List.of(products), listaFaltantes);
  }
  ;

  // Ya que tenemos lo que puede satisfacer las necesidades del cliente
  // falta ver el tema de cuál tienda necesita más clientes
  var clientesPromedio = 0.0;
  var listaTiendasMenosClientes = <DistanciaMarcador>[];
  for (var listaAux in listaRecursivaCombinacionesTiendasCumplenConElCliente) {
    var promedioListTemporal = 0.0;
    for (var distMarc in listaAux) {
      promedioListTemporal += distMarc.marcador.vistos;
    }
    promedioListTemporal = promedioListTemporal / listaAux.length;
    if (clientesPromedio == 0.0) {
      clientesPromedio = promedioListTemporal;
      listaTiendasMenosClientes = listaAux;
    }
    print('clientes');
    print(promedioListTemporal);
    if (clientesPromedio > promedioListTemporal) {
      clientesPromedio = promedioListTemporal;
      listaTiendasMenosClientes = listaAux;
    }
  }

  // Hasta aquí ya tenemos a la lista de tiendas más necesitadas
  // hay que agregarles 1 cliente y cambiar el horario
  /* for (DistanciaMarcador distMarc in listaTiendasMenosClientes) {
    print(distMarc.marcador.nombre);
     await Firestore.instance
          .collection(collection)
          .document(distMarc.marcador.id)
          .updateData({'clientes': FieldValue.increment(1)});
      if (distMarc.marcador.hora.millisecondsSinceEpoch <
          DateTime.now().millisecondsSinceEpoch) {
        await Firestore.instance
            .collection(collection)
            .document(distMarc.marcador.id)
            .updateData({'hora': DateTime.now()});
      } else {
        await Firestore.instance
            .collection(collection)
            .document(distMarc.marcador.id)
            .updateData({
          'hora': DateTime.fromMicrosecondsSinceEpoch(
                  distMarc.marcador.hora.millisecondsSinceEpoch)
              .add(Duration(minutes: 10))
        });
      } 

  } */

  // Lista en caso de que no haya suficientes tiendas para surtir la lista de la despensa
  var listaDefault = <DistanciaMarcador>[];
  var distMarcadorDefault = DistanciaMarcador();
  var marcadorDefault = Marcador();
  marcadorDefault.nombre =
      'No pudimos completar tu ticket; puedes mapear más tiendas por tu zona o buscarlas individualmente';
  marcadorDefault.imagen =
      'https://previews.123rf.com/images/elenabsl/elenabsl1409/elenabsl140900005/31392676-street-map.jpg';
  distMarcadorDefault.marcador = marcadorDefault;
  distMarcadorDefault.distancia = '--';
  listaDefault.add(distMarcadorDefault);

  return listaTiendasMenosClientes.isNotEmpty
      ? listaTiendasMenosClientes
      : listaDefault;
}

void getCombinacionRecursiva(
    List<DistanciaMarcador> listaTemporal,
    DistanciaMarcador marcadorSiguiente,
    List<bool> productosFaltantes,
    List<DistanciaMarcador> listaFaltantes) async {
  var necesarios = 0;

  for (var i = 0;
      i <
          min(marcadorSiguiente.marcador.productos.length,
              productosFaltantes.length);
      i++) {
    if (marcadorSiguiente.marcador.productos[i] && productosFaltantes[i]) {
      necesarios++;
    }
  }

  if (necesarios > 0) {
    // Marcar este como parte de la permutación
    listaTemporal.add(marcadorSiguiente);

    // Quitar este elemento de la lista de faltantes
    listaFaltantes.remove(marcadorSiguiente);

    // Marcar los servicios que ya cumplimos
    for (var i = 0;
        i <
            min(marcadorSiguiente.marcador.productos.length,
                productosFaltantes.length);
        i++) {
      if (marcadorSiguiente.marcador.productos[i]) {
        productosFaltantes[i] = false;
      }
    }

    // Verificar si ya con esto terminamos de cumplir las necesidades
    var necesariosFaltantes = 0;

    for (var i = 0; i < productosFaltantes.length; i++) {
      if (productosFaltantes[i]) {
        necesariosFaltantes++;
      }
    }

    // Si aún quedan necesidades por cumplir, vamos recursivamente
    // Si no es el caso, agregamos esta permutación a la lista de los que cumplen con las necesidades del cliente
    if (necesariosFaltantes > 0) {
      for (var distMarc in listaFaltantes) {
        // Vamos a repetir la recursividad
        await getCombinacionRecursiva(List.from(listaTemporal), distMarc,
            List.from(productosFaltantes), List.from(listaFaltantes));
      }
    } else {
      listaRecursivaCombinacionesTiendasCumplenConElCliente.add(listaTemporal);
    }
    ;
  }
}
