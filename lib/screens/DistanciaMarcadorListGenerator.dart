import 'package:flutter/material.dart';
import 'package:remap/components/imageCard.dart';
import 'package:remap/utils/models.dart';

import 'DetailScreen.dart';

class DistanciaMarcadorListGenerator extends StatelessWidget {
  const DistanciaMarcadorListGenerator({
    Key key,
    @required this.listaDistanciaMarcador,
  }) : super(key: key);

  final List<DistanciaMarcador> listaDistanciaMarcador;

  @override
  Widget build(BuildContext context) {
    var callback = (dynamic objectParameter) => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                      marc: (objectParameter as DistanciaMarcador).marcador,
                    )),
          )
        };

    return ListView(
        children: (listaDistanciaMarcador).map((marc) {
      return ImageCard(
        onPressed: () => callback(marc),
        nombre: marc.marcador.nombre,
        url: marc.marcador.imagen,
        distancia: marc.distancia,
      );
    }).toList());
  }
}
