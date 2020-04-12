import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ImageListScreen.dart';
import 'MapScreen.dart';
import 'SelectProductsScreen.dart';

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
      case 0:
        return SelectProductscreen();
        break;
      case 1:
        return ImageListScreen();
        break;
      case 2:
        return MapScreen();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Gonzalo's Flutter UI"),
    );

    return Scaffold(
      appBar: appBar,
      body: screens(context, currentPage),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.home, title: "Comprar"),
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
  }
}
