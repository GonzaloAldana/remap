import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remap/lists/DistanciaMarcadorListGenerator.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/models.dart';
import 'package:remap/utils/functions.dart';

class SmartTicketScreen extends StatelessWidget {
  final List<bool> listaProductos;
  static TiendaStore tiendaStore;

  const SmartTicketScreen({
    Key key,
    this.listaProductos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tiendaStore == null) {
      tiendaStore = Provider.of<TiendaStore>(context, listen: false);
    }

    var appBar = AppBar(
      title: Text("Ticket Inteligente"),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        child: FutureBuilder(
          future: getSmartTicket("tiendas", 2, listaProductos,
              tiendaStore.listaDistanciaMarcadores),
          builder: (context, marcadores) {
            if (!marcadores.hasData) {
              return MyConstants.of(context).progressIndicator;
            }
            return DistanciaMarcadorListGenerator(
                listaDistanciaMarcador:
                    marcadores.data as List<DistanciaMarcador>,
                countryCode: tiendaStore.countryCode,
                mostrarHorario: false);
          },
        ),
      ),
    );
  }
}
