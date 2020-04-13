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
