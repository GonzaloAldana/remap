import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:latlong/latlong.dart';

import 'AddMarkerScreen.dart';
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

    var tileLayerOptions = TileLayerOptions(
      urlTemplate:
          "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
      //: "https://api.mapbox.com/styles/v1/{id}/tiles/256/{z}/{x}/{y}?access_token={accessToken}",
      additionalOptions: {
        'accessToken':
            'pk.eyJ1IjoiZ29uemFsbzk3IiwiYSI6ImNqbHF6NHV6MjAxMmIzcG1nMnBuMmgwMDgifQ.ZbuwSMu9bFrdNof0zfbFgw',
        'id': 'mapbox.streets',
        //: 'gonzalo97/cjxm4rj4g1hyj1cmwamidao0u',
      },
    );

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
      tiendaStore.listaMarcadores.forEach(
        (marc) {
          markers.add(
            Marker(
              anchorPos: AnchorPos.align(AnchorAlign.center),
              height: 30,
              width: 30,
              point: LatLng(marc.lat, marc.lon),
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

      return FlutterMap(
        options: MapOptions(
          onTap: (LatLng coord) {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SafeArea(
                    child: ListTile(
                      leading: Icon(Icons.build),
                      title: Text("Mapear tienda aquí"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddMarkerScreen(pos: coord),
                          ),
                        );
                      },
                    ),
                  );
                });
          },
          center: LatLng(
              tiendaStore.position.latitude, tiendaStore.position.longitude),
          zoom: 14,
          plugins: [
            MarkerClusterPlugin(),
          ],
        ),
        layers: [
          tileLayerOptions,
          markerClusterOptions,
        ],
      );
    });
  }
}
