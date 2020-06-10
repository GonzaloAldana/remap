import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:remap/atoms/imageButton.dart';
import 'package:remap/components/imageCard.dart';
import 'package:remap/screens/ImageScreen.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/functions.dart';
import 'package:remap/utils/models.dart';
import 'package:remap/utils/utils.dart';
import 'package:pedantic/pedantic.dart';

class DetailScreen extends StatelessWidget {
  final DistanciaMarcador marc;
  final String horario;

  const DetailScreen({Key key, this.marc, this.horario = ''}) : super(key: key);

  static TiendaStore tiendaStore;

  @override
  Widget build(BuildContext context) {
    if (tiendaStore == null) {
      tiendaStore = Provider.of<TiendaStore>(context, listen: false);
    }

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
                GlobalKey<State> _keyLoader = GlobalKey<State>();

                unawaited(showLoadingDialog(context, _keyLoader)); //invokin
                await putStatiscticsUpdate(tiendaStore.countryCode, marc, 2);
                await shareImage(marc.marcador.imagen);
                Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                    .pop();
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
              builder: (context) => ImageScreen(marc),
            ),
          )
        };

    var imagenDetalle = ImageCard(
      nombre: marc.marcador.nombre,
      url: marc.marcador.imagen,
      distancia: marc.distancia,
      onPressed: callBack,
    );

    var btnLanzarMapa = ImageButton(
      texto:
          horario.isEmpty ? 'Planear ruta' : 'Planear ruta' + ('\n' + horario),
      isBig: horario.isNotEmpty,
      url:
          'https://previews.123rf.com/images/elenabsl/elenabsl1409/elenabsl140900005/31392676-street-map.jpg',
      icono: FontAwesomeIcons.telegramPlane,
      onPressed: () =>
          launchMap(marc.marcador.lat.toString(), marc.marcador.lon.toString()),
    );

    var btnContactar = ImageButton(
      texto: 'Contactar al vendedor',
      isBig: horario.isNotEmpty,
      url:
          'https://previews.123rf.com/images/elenabsl/elenabsl1409/elenabsl140900005/31392676-street-map.jpg',
      icono: FontAwesomeIcons.whatsapp,
      onPressed: () async {
        await putStatiscticsUpdate(tiendaStore.countryCode, marc, 3);
        await launchWhatsApp(marc);
      },
    );

    var separador = SizedBox(height: 15);

    return SafeArea(
      child: Scaffold(
          appBar: appBar,
          body: Container(
              child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    children: <Widget>[
                      imagenDetalle,
                      separador,
                      btnLanzarMapa,
                      separador,
                      btnContactar,
                      separador,
                      for (MapEntry entry
                          in marc.marcador.productos.asMap().entries)
                        entry.value
                            ? Card(
                                child: ListTile(
                                  title: Text(MyConstants.of(context)
                                      .listaProductos[entry.key]),
                                  trailing: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                ),
                              )
                            : Container(),
                      for (MapEntry entry
                          in marc.marcador.servicios.asMap().entries)
                        entry.value
                            ? Card(
                                child: ListTile(
                                  title: Text(MyConstants.of(context)
                                      .listaServicios[entry.key]),
                                  trailing: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                ),
                              )
                            : Container(),
                      for (MapEntry entry
                          in marc.marcador.serviciosCliente.asMap().entries)
                        entry.value
                            ? Card(
                                child: ListTile(
                                  title: Text(MyConstants.of(context)
                                      .listaServiciosCliente[entry.key]),
                                  trailing: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                ),
                              )
                            : Container(),
                      Container(
                        height: 20,
                      )
                    ],
                  )
                ]),
              )
            ],
          ))),
    );
  }
}
