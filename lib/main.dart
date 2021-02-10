import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:remap/screens/NavigationBar.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:remap/utils/constants.dart';

void main() => runApp(MyConstants(child: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-5432738380804980~6193133091');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Provider<TiendaStore>(
        create: (_) => TiendaStore(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Meica',
          theme: ThemeData(
            primaryColor: MyConstants.of(context).color1,
            accentColor: MyConstants.of(context).color2,
            fontFamily: MyConstants.of(context).fontFamily,
            primarySwatch: Colors.blue,
          ),
          home: SafeArea(child: NavigationBar()),
        ));
  }
}
