import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:latlong/latlong.dart';
import 'package:remap/utils/constants.dart';

import 'DetailScreen.dart';

class MapScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MapScreen> {
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TiendaStore tiendaStore = Provider.of<TiendaStore>(context, listen: false);

    var markerPolygonOptions = PolygonOptions(
        borderColor: Theme.of(context).accentColor,
        color: Colors.black12,
        borderStrokeWidth: 3);

    var btnCluster = (markers) => RaisedButton(
          color: Theme.of(context).accentColor,
          disabledColor: Theme.of(context).accentColor,
          disabledTextColor: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(markers.length.toString()),
          onPressed: null,
        );

    return Observer(builder: (_) {
      markers = [];
      tiendaStore.listaDistanciaMarcadores.forEach(
        (marc) {
          markers.add(
            Marker(
              anchorPos: AnchorPos.align(AnchorAlign.center),
              height: 30,
              width: 30,
              point: LatLng(marc.marcador.lat, marc.marcador.lon),
              builder: (context) => IconButton(
                icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                color: Theme.of(context).accentColor,
                iconSize: 30.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(marc: marc),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );

      var markerClusterOptions = MarkerClusterLayerOptions(
        maxClusterRadius: 120,
        size: Size(50, 50),
        anchor: AnchorPos.align(AnchorAlign.center),
        fitBoundsOptions: FitBoundsOptions(
          padding: EdgeInsets.all(10),
        ),
        markers: markers,
        polygonOptions: markerPolygonOptions,
        builder: (context, markers) => btnCluster(markers),
      );
      var circles = CircleLayerOptions(circles: [
        CircleMarker(
            point: LatLng(
                tiendaStore.position.latitude, tiendaStore.position.longitude),
            radius: 1500,
            useRadiusInMeter: true,
            borderStrokeWidth: 2,
            borderColor: Theme.of(context).accentColor,
            color: Colors.black.withAlpha(10))
      ]);

      return FlutterMap(
        options: MapOptions(
          center: LatLng(
              tiendaStore.position.latitude, tiendaStore.position.longitude),
          zoom: 14,
          plugins: [
            MarkerClusterPlugin(),
          ],
        ),
        layers: [
          MyConstants.of(context).tileLayerOptions,
          circles,
          markerClusterOptions
        ],
      );
    });
  }
}
