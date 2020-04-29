import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:remap/utils/constants.dart';
import 'ImageListScreen.dart';
import 'MapScreen.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({
    Key key,
  }) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int currentPage = 0;

  screens(BuildContext rootContext, int _tabIndex) {
    switch (_tabIndex) {
      /*  case 0:
        return SelectProductscreen();
        break; */
      case 0:
        return ImageListScreen();
        break;
      case 1:
        return MapScreen();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    TiendaStore tiendaStore = Provider.of<TiendaStore>(context, listen: false);

    if (tiendaStore.everythingIsLoading) tiendaStore.loadEverything();

    var appBar = AppBar(
      title: Text('ReMap 4.0'),
    );

    var pantallaLoading = Scaffold(
        backgroundColor: MyConstants.of(context).color1,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 200.0, child: Image.asset('assets/logo.png')),
            SizedBox(height: 50),
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text(
              'Buscando negocios cercanos',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        )));

    var pantallaNavegacion = Scaffold(
      appBar: appBar,
      body: screens(context, currentPage),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          //TabData(iconData: Icons.home, title: "Comprar"),
          TabData(iconData: Icons.location_city, title: "Negocios"),
          TabData(iconData: FontAwesomeIcons.mapMarkerAlt, title: "Mapa")
        ],
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

    return Observer(
      builder: (_) => (!tiendaStore.everythingIsLoading)
          ? pantallaNavegacion
          : pantallaLoading,
    );
  }
}
