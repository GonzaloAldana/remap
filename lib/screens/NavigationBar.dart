import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jumping_bottom_nav_bar/jumping_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:remap/screens/ContactScreen.dart';
import 'package:remap/screens/HomeScreen.dart';
import 'package:remap/screens/SelectProductsScreen.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';
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
  int currentPage = 1;
  TiendaStore tiendaStore;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (tiendaStore == null) {
      tiendaStore = Provider.of<TiendaStore>(context, listen: false);
    }

    if (tiendaStore.everythingIsLoading) tiendaStore.loadEverything();

    var iconList = [
      TabItemIcon(
          curveColor: MyConstants.of(context).color1.withAlpha(100),
          iconData: Icons.home,
          startColor: MyConstants.of(context).colorGray),
      TabItemIcon(
          curveColor: MyConstants.of(context).color1.withAlpha(100),
          iconData: Icons.location_city,
          startColor: MyConstants.of(context).colorGray),
      TabItemIcon(
          curveColor: MyConstants.of(context).color1.withAlpha(100),
          iconData: FontAwesomeIcons.mapMarkerAlt,
          startColor: MyConstants.of(context).colorGray),
      TabItemIcon(
          curveColor: MyConstants.of(context).color1.withAlpha(100),
          iconData: Icons.list,
          startColor: MyConstants.of(context).colorGray),
    ];

    var appBar = AppBar(
      title: Container(
        height: getResponsiveDps(35, width),
        width: getResponsiveDps(35, width),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/meicaBlanco.png'), fit: BoxFit.cover),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.textsms,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactScreen()),
            );
          },
        )
      ],
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

    var pantallaNavegacion = DefaultTabController(
        length: iconList.length,
        child: Scaffold(
          appBar: appBar,
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              ImageListScreen(),
              MapScreen(),
              SelectProductscreen()
            ],
          ),
          bottomNavigationBar: JumpingTabBar(
            onChangeTab: (position) {
              currentPage = position;
            },
            circleGradient: LinearGradient(
              colors: [
                MyConstants.of(context).color2,
                MyConstants.of(context).color2Gradient
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            items: iconList,
            selectedIndex: currentPage,
          ),
        ));

    return Observer(
      builder: (_) => (!tiendaStore.everythingIsLoading)
          ? pantallaNavegacion
          : pantallaLoading,
    );
  }
}
