import 'package:flutter/material.dart';
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
    );
  }
}
