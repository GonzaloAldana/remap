import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MyConstants extends InheritedWidget {
  static MyConstants of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyConstants>();

  MyConstants({Widget child, Key key}) : super(key: key, child: child);

  final String successMessage = 'Some message';
  final Color color1 = Color(0xff009A8E); //Color(0xff584BDD);
  final Color color2 = Color(0xffFFC500); //Color(0xffB154FD);
  final Color color2Gradient = Color(0xfffdb05e); //Color(0xffB154FD);
  final Color colorGray = Color(0xff454545);
  final String fontFamily = 'Montserrat';
  final double titleSize = 19;
  final double midTitleSize = 16;
  final double textSize = 13;
  final FontWeight fontLight = FontWeight.w400;
  final FontWeight fontMedium = FontWeight.w600;
  final FontWeight fontSemiBold = FontWeight.w800;

  final listaServicios = [
    'Estética',
    'Restaurante o Comida preparada',
    'Servicios médicos',
    'Reparación',
    'Gimnasio',
    'Otro'
  ];

  final listaProductos = [
    'Tienda de abarrotes',
    'Carnicería',
    'Panadería',
    'Frutas y Verduras',
    'Tienda de mascotas',
    'Farmacia',
    'Tortillería',
    'Otro'
  ];

  final listaServiciosCliente = [
    'Medios de pago electrónico',
    'Servicio a domicilio'
  ];

  final Widget progressIndicator = CircularProgressIndicator();

  final tileLayerOptions = TileLayerOptions(
    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    subdomains: ['a', 'b', 'c'],
  );

  @override
  bool updateShouldNotify(MyConstants oldWidget) => false;
}
