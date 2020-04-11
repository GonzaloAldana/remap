import 'package:flutter/material.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class ContainerSeparator extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final Widget child;
  const ContainerSeparator({Key key, this.titulo, this.subtitulo, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    var containerTitulo = titulo != null
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: getResponsiveDps(20, width)),
            child: Text(titulo,
                style: TextStyle(
                    fontSize: MyConstants.of(context).midTitleSize,
                    fontWeight: MyConstants.of(context).fontMedium,
                    color: Colors.black)),
          )
        : Container();

    var containerSubtitulo = subtitulo != null
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: getResponsiveDps(20, width)),
            child: Text(subtitulo,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: MyConstants.of(context).midTitleSize,
                    fontWeight: MyConstants.of(context).fontLight,
                    color: Colors.black87)),
          )
        : Container();

    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
        color: MyConstants.of(context).colorGray,
        width: 0.5,
      ))),
      width: getResponsiveDps(375, width),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        SizedBox(height: getResponsiveDps(15, width)),
        containerTitulo,
        SizedBox(height: getResponsiveDps(2, width)),
        containerSubtitulo,
        SizedBox(height: getResponsiveDps(12, width)),
        child != null ? child : Container(),
        SizedBox(height: getResponsiveDps(20, width))
      ]),
    );
  }
}
