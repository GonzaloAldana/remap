import 'package:cloud_firestore/cloud_firestore.dart';

class Marcador {
  String id;
  String nombre;
  String imagen;
  double lat;
  double lon;
  List<bool> servicios;
  List<bool> productos;
  int vistos;
  Timestamp hora;
  String horaApertura;
  String horaCierre;
  List<bool> serviciosCliente;
  String telefono;

  Marcador(
      {this.id,
      this.nombre,
      this.imagen,
      this.lat,
      this.lon,
      this.servicios,
      this.productos,
      this.vistos,
      this.hora,
      this.horaApertura,
      this.horaCierre,
      this.serviciosCliente,
      this.telefono});

  Marcador.fromMap(Map snapshot, String id)
      : id = id ?? '',
        nombre = snapshot['nombre'] ?? '',
        imagen = snapshot['imagen'] ?? '',
        lat = snapshot['lat'] ?? '',
        lon = snapshot['lon'] ?? '',
        servicios = snapshot['servicios'].cast<bool>() ?? '',
        productos = snapshot['productos'].cast<bool>() ?? '',
        vistos = snapshot['vistos'] ?? '',
        hora = snapshot['hora'] ?? '',
        horaApertura = snapshot['horaApertura'] ?? '',
        horaCierre = snapshot['horaCierre'] ?? '',
        serviciosCliente = snapshot['serviciosCliente'].cast<bool>() ?? '',
        telefono = snapshot['telefono'] ?? '';

  toJson() {
    return {
      "nombre": nombre,
      "imagen": imagen,
      "lat": lat,
      "lon": lon,
      'servicios': servicios,
      ' productos': productos
    };
  }
}

class DistanciaMarcador {
  Marcador marcador;
  String distancia;

  DistanciaMarcador({this.marcador, this.distancia});
}

class SmartTicket {
  DistanciaMarcador distanciaMarcador;
  String horario;

  SmartTicket({this.distanciaMarcador, this.horario});
}

class Aliado {
  String nombre;
  String imagen;

  Aliado({this.nombre, this.imagen});
  Aliado.fromMap(Map snapshot)
      : nombre = snapshot['nombre'] ?? '',
        imagen = snapshot['imagen'] ?? '';
}
