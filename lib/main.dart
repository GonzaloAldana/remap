import 'package:flutter/material.dart';
import 'package:remap/screens/NavigationBar.dart';
import 'package:remap/screens/SearchScreen.dart';
import 'package:remap/utils/constants.dart';

void main() => runApp(MyConstants(child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Remap 4.0',
      theme: ThemeData(
        primaryColor: MyConstants.of(context).color1,
        accentColor: MyConstants.of(context).color2,
        fontFamily: MyConstants.of(context).fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
          child: // NavigationBar()
              SearchScreen()),
    );
  }
}
