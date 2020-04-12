import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class MyConstants extends InheritedWidget {
  static MyConstants of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyConstants>();

  MyConstants({Widget child, Key key}) : super(key: key, child: child);

  final String successMessage = 'Some message';
  final Color color1 = Color(0xff584BDD);
  final Color color2 = Color(0xffB154FD);
  final Color colorGray = Color(0xff454545);
  final String fontFamily = 'Montserrat';
  final double titleSize = 19;
  final double midTitleSize = 16;
  final double textSize = 13;
  final FontWeight fontLight = FontWeight.w400;
  final FontWeight fontMedium = FontWeight.w600;
  final FontWeight fontSemiBold = FontWeight.w800;

  final listaServicios = ['Estética', 'Gimnasio'];
  final listaProductos = ['Frutas', 'Verduras', 'Carne', 'Pan', 'Abarrotes'];

  final LoadingDoubleFlipping progressIndicator = LoadingDoubleFlipping.circle(
    borderColor: Colors.cyan,
    borderSize: 3.0,
    size: 100.0,
    backgroundColor: Colors.cyanAccent,
    duration: Duration(milliseconds: 500),
  );

  @override
  bool updateShouldNotify(MyConstants oldWidget) => false;
}
