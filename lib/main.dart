import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remap/screens/NavigationBar.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:remap/utils/constants.dart';

void main() => runApp(MyConstants(child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<TiendaStore>(
      create: (_) => TiendaStore(),
      child: MaterialApp(
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
                NavigationBar()),
      ),
    );
  }
}
