import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remap/atoms/imageButton.dart';
import 'package:remap/components/imageCard.dart';
import 'package:remap/screens/ImageScreen.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/functions.dart';
import 'package:remap/utils/models.dart';

class DetailScreen extends StatelessWidget {
  final Marcador marc;
  final String horario;

  const DetailScreen({Key key, this.marc, this.horario = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                await shareImage(marc.imagen);
              },
              child: Icon(
                Icons.share,
                size: 26.0,
              ),
            )),
      ],
    );

    var callBack = () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageScreen(marc.imagen),
            ),
          )
        };

    var imagenDetalle = ImageCard(
      nombre: marc.nombre,
      url: marc.imagen,
      distancia: ' ',
      onPressed: callBack,
    );

    var btnLanzarMapa = ImageButton(
      texto:
          horario.isEmpty ? 'Planear ruta' : 'Planear ruta' + ('\n' + horario),
      isBig: horario.isNotEmpty,
      url:
          'https://previews.123rf.com/images/elenabsl/elenabsl1409/elenabsl140900005/31392676-street-map.jpg',
      icono: FontAwesomeIcons.telegramPlane,
      onPressed: () => launchMap(marc.lat.toString(), marc.lon.toString()),
    );

    var listaProductosServicios = Expanded(
      child: ListView(
        children: [
          for (MapEntry entry in marc.productos.asMap().entries)
            entry.value
                ? Card(
                    child: ListTile(
                      title: Text(
                          MyConstants.of(context).listaProductos[entry.key]),
                      trailing: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                  )
                : Container(),
          for (MapEntry entry in marc.servicios.asMap().entries)
            entry.value
                ? Card(
                    child: ListTile(
                      title: Text(
                          MyConstants.of(context).listaServicios[entry.key]),
                      trailing: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                  )
                : Container()
        ],
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Container(
          child: Column(
            children: [imagenDetalle, btnLanzarMapa, listaProductosServicios],
          ),
        ),
      ),
    );
  }
}
