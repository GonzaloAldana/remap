class Marcador {
  String id;
  String nombre;
  String imagen;
  double lat;
  double lon;
  List<bool> servicios;
  List<bool> productos;
  int clientes;

  Marcador(
      {this.id,
      this.nombre,
      this.imagen,
      this.lat,
      this.lon,
      this.servicios,
      this.productos,
      this.clientes});

  Marcador.fromMap(Map snapshot, String id)
      : id = id ?? '',
        nombre = snapshot['nombre'] ?? '',
        imagen = snapshot['imagen'] ?? '',
        lat = snapshot['lat'] ?? '',
        lon = snapshot['lon'] ?? '',
        servicios = snapshot['servicios'].cast<bool>() ?? '',
        productos = snapshot['productos'].cast<bool>() ?? '',
        clientes = snapshot['clientes'] ?? '';

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
