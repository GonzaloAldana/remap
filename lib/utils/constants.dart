import 'package:flutter/material.dart';

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

  @override
  bool updateShouldNotify(MyConstants oldWidget) => false;
}
