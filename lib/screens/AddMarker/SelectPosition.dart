import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:remap/utils/constants.dart';

import 'SelectServiceProduct.dart';

class SelectPositionScreen extends StatefulWidget {
  const SelectPositionScreen({Key key}) : super(key: key);

  @override
  _SelectPositionScreenState createState() => _SelectPositionScreenState();
}

class _SelectPositionScreenState extends State<SelectPositionScreen> {
  LatLng _center;
  List<Marker> markers;
  double radius = 500;

  generarMarker() {
    markers = [
      Marker(
        height: 30,
        width: 30,
        point: _center,
        builder: (context) => Icon(FontAwesomeIcons.solidHandPointDown,
            color: Theme.of(context).accentColor, size: 30.0),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    TiendaStore tiendaStore = Provider.of<TiendaStore>(context, listen: false);

    if (_center == null) {
      _center =
          LatLng(tiendaStore.position.latitude, tiendaStore.position.longitude);
    }

    generarMarker();

    var markerLayerOptions = MarkerLayerOptions(markers: markers);

    var btnRegresar = IconButton(
      icon: Icon(
        Icons.keyboard_arrow_left,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );

    var btnOk = IconButton(
      icon: Icon(
        Icons.done,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectServiceProductScreen(pos: _center),
          ),
        );
      },
    );

    var mapa = FlutterMap(
      options: MapOptions(
        onTap: (LatLng coord) {
          _center = coord;
          setState(() {
            generarMarker();
          });
        },
        center: _center,
        zoom: 14,
        plugins: [],
      ),
      layers: [MyConstants.of(context).tileLayerOptions, markerLayerOptions],
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('¿Dónde está la tienda?'),
          leading: btnRegresar,
          actions: <Widget>[btnOk],
        ),
        body: mapa);
  }
}
