import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remap/components/imageCard.dart';
import 'package:remap/utils/models.dart';

import 'DetailScreen.dart';

class DistanciaMarcadorListGenerator extends StatelessWidget {
  const DistanciaMarcadorListGenerator(
      {Key key,
      @required this.listaDistanciaMarcador,
      this.mostrarHorario = false})
      : super(key: key);

  final List<DistanciaMarcador> listaDistanciaMarcador;
  final bool mostrarHorario;

  @override
  Widget build(BuildContext context) {
    var callback = (dynamic objectParameter) => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                marc: (objectParameter as DistanciaMarcador).marcador,
                horario: mostrarHorario
                    ? DateFormat.Hm()
                        .format(
                          DateTime.fromMicrosecondsSinceEpoch(
                              (objectParameter as DistanciaMarcador)
                                  .marcador
                                  .hora
                                  .millisecondsSinceEpoch),
                        )
                        .toString()
                    : '',
              ),
            ),
          )
        };

    return ListView(
        children: (listaDistanciaMarcador).map((marc) {
      return ImageCard(
        onPressed: marc.distancia != '--' ? () => callback(marc) : null,
        nombre: marc.marcador.nombre,
        url: marc.marcador.imagen,
        distancia: marc.distancia,
      );
    }).toList());
  }
}
