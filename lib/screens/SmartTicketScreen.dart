import 'package:flutter/material.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/models.dart';
import 'package:remap/utils/functions.dart';

import 'DistanciaMarcadorListGenerator.dart';

class SmartTicketScreen extends StatelessWidget {
  final List<bool> listaServicios;
  final List<bool> listaProductos;

  const SmartTicketScreen({
    Key key,
    this.listaServicios,
    this.listaProductos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Ticket Inteligente"),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        child: FutureBuilder(
          future: getSmartTicket("tiendas", 2, listaProductos, listaServicios),
          builder: (context, marcadores) {
            if (!marcadores.hasData) {
              return MyConstants.of(context).progressIndicator;
            }
            return DistanciaMarcadorListGenerator(
                listaDistanciaMarcador:
                    marcadores.data as List<DistanciaMarcador>);
          },
        ),
      ),
    );
  }
}
