import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/models.dart';
import 'package:remap/utils/functions.dart';

import 'DistanciaMarcadorListGenerator.dart';

class ImageListScreen extends StatelessWidget {
  const ImageListScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
