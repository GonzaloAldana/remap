import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
            future: getPosition(),
            builder: (context, posicion) {
              if (!posicion.hasData) {
                return MyConstants.of(context).progressIndicator;
              }
              return FutureBuilder(
                  future: getMarcadores("tiendas"),
                  builder: (context, marcadores) {
                    return FutureBuilder(
                        future: getDistanciasMarcadores(
                            marcadores.data,
                            (posicion.data as Position).latitude,
                            (posicion.data as Position).longitude),
                        builder: (context, snp) {
                          if (!snp.hasData) {
                            return MyConstants.of(context).progressIndicator;
                          }
                          return DistanciaMarcadorListGenerator(
                              listaDistanciaMarcador:
                                  snp.data as List<DistanciaMarcador>);
                        });
                  });
            }),
      ),
    );
  }
}
