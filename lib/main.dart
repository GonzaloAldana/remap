import 'package:flutter/material.dart';
import 'package:remap/utils/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: MyConstants.of(context).color1,
        accentColor: MyConstants.of(context).color2,
        fontFamily: MyConstants.of(context).fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(child: Container()),
    );
  }
}
