import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remap/components/imageCard.dart';
import 'package:remap/screens/DetailScreen.dart';
import 'package:remap/utils/functions.dart';
import 'package:remap/utils/models.dart';

class DistanciaMarcadorListGenerator extends StatefulWidget {
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
  _DistanciaMarcadorListGeneratorState createState() =>
      _DistanciaMarcadorListGeneratorState();
}

class _DistanciaMarcadorListGeneratorState
    extends State<DistanciaMarcadorListGenerator> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    nonPersonalizedAds: true,
  );

  InterstitialAd _interstitialAd;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: 'ca-app-pub-5432738380804980/9972310590',
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print('IntersttialAd $event');
          if (event == MobileAdEvent.closed) dispose();
        });
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  int anuncios = 0;

  @override
  Widget build(BuildContext context) {
    var callback = (dynamic objectParameter) async {
      if (anuncios % 3 == 0) {
        createInterstitialAd()
          ..load()
          ..show();
      }
      anuncios++;
      await putStatiscticsUpdate(
          widget.countryCode, (objectParameter as DistanciaMarcador), 1);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(
            marc: (objectParameter as DistanciaMarcador),
            horario: widget.mostrarHorario
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
      controller: widget.controller,
      shrinkWrap: true,
      itemCount: widget.listaDistanciaMarcador.length,
      itemBuilder: (context, index) {
        var marc = widget.listaDistanciaMarcador[index];
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
