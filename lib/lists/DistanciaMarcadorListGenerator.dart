import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remap/components/imageCard.dart';
import 'package:remap/screens/DetailScreen.dart';
import 'package:remap/utils/functions.dart';
import 'package:remap/utils/models.dart';

class DistanciaMarcadorListGenerator extends StatelessWidget {
  const DistanciaMarcadorListGenerator(
      {Key key,
      @required this.listaDistanciaMarcador,
      this.mostrarHorario = false,
      this.controller,
      @required this.countryCode})
      : super(key: key);

  final List<DistanciaMarcador> listaDistanciaMarcador;
  final bool mostrarHorario;
  final ScrollController controller;
  final String countryCode;

  @override
  Widget build(BuildContext context) {
    var callback = (dynamic objectParameter) async {
      await putStatiscticsUpdate(
          countryCode, (objectParameter as DistanciaMarcador), 1);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(
            marc: (objectParameter as DistanciaMarcador),
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
      );
    };

    return ListView.builder(
      controller: controller,
      shrinkWrap: true,
      itemCount: listaDistanciaMarcador.length,
      itemBuilder: (context, index) {
        DistanciaMarcador marc = listaDistanciaMarcador[index];
        return ImageCard(
          onPressed: marc.distancia != '--' ? () => callback(marc) : null,
          nombre: marc.marcador.nombre,
          url: marc.marcador.imagen,
          distancia: marc.distancia,
        );
      },
    );
  }
}
