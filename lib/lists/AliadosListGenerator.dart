import 'package:flutter/material.dart';
import 'package:remap/components/faceCard.dart';
import 'package:remap/utils/models.dart';
import 'package:remap/utils/utils.dart';

class AliadosListGenerator extends StatelessWidget {
  final List<Aliado> aliados;
  const AliadosListGenerator({Key key, this.aliados}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: getResponsiveDps(160, width),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: aliados.length,
        itemBuilder: (BuildContext context, int index) {
          return FaceCard(
              nombre: aliados[index].nombre, url: aliados[index].imagen);
        },
      ),
    );
  }
}
