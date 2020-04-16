import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/functions.dart';
import 'package:remap/utils/models.dart';
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

    var markerClusterOptions = MarkerClusterLayerOptions(
      maxClusterRadius: 120,
      size: Size(40, 40),
      anchor: AnchorPos.align(AnchorAlign.center),
      fitBoundsOptions: FitBoundsOptions(
        padding: EdgeInsets.all(50),
      ),
      markers: markers,
      polygonOptions: markerPolygonOptions,
      builder: (context, markers) => btnCluster(markers),
    );

    return Container(
      child: FutureBuilder(
        future: getMarcadores("tiendas"),
        builder: (context, snp) {
          if (!snp.hasData) {
            return MyConstants.of(context).progressIndicator;
          }

          (snp.data as List<Marcador>).forEach(
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
                            print('presionado');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddMarkerScreen(pos: coord),
                              ),
                            );
                            /* actuales.add(coord);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PantallaAgregarMapa(actuales))); */
                          },
                        ),
                      );
                    });
              },
              center: LatLng(21.13091174983556, -101.68654561042786),
              zoom: 12,
              plugins: [
                MarkerClusterPlugin(),
              ],
            ),
            layers: [
              tileLayerOptions,
              markerClusterOptions,
            ],
          );
        },
      ),
    );
  }
}
