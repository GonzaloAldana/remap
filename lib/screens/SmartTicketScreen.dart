import 'package:flutter/material.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/models.dart';
import 'package:remap/utils/functions.dart';

import 'DistanciaMarcadorListGenerator.dart';

class SmartTicketScreen extends StatelessWidget {
  const SmartTicketScreen({
    Key key,
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
            future: getMarcadores("tiendas"),
            builder: (context, marcadores) {
              return FutureBuilder(
                  future: getDistanciasMarcadores(marcadores.data, 20.0, -101),
                  builder: (context, snp) {
                    if (!snp.hasData) {
                      return MyConstants.of(context).progressIndicator;
                    }
                    return DistanciaMarcadorListGenerator(
                        listaDistanciaMarcador:
                            snp.data as List<DistanciaMarcador>);
                  });
            }),
      ),
    );
  }
}
