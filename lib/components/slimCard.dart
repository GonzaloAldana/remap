import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class SlimCard extends StatelessWidget {
  final String nombre;
  final String url;
  final Function onPressed;

  const SlimCard({Key key, this.nombre, this.url, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    var cardImage = CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: getResponsiveDps(199, width),
        width: getResponsiveDps(162, width),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(getResponsiveDps(7, width))),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Container(
        child: CircularProgressIndicator(),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(getResponsiveDps(7, width)))),
        height: getResponsiveDps(199, width),
        width: getResponsiveDps(162, width),
      ),
      errorWidget: (context, url, error) => Opacity(
          opacity: 0.1,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(getResponsiveDps(7, width)))),
            height: getResponsiveDps(199, width),
            width: getResponsiveDps(162, width),
          )),
    );

    var backgroundContainer = Positioned(
      bottom: 0,
      child: Container(
        height: getResponsiveDps(50, width),
        width: getResponsiveDps(162, width),
        decoration: BoxDecoration(
            color: MyConstants.of(context).colorGray.withOpacity(0.5),
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(getResponsiveDps(7, width)))),
      ),
    );

    var txtNombre = Positioned(
      bottom: 0,
      child: Container(
          padding: EdgeInsets.all(getResponsiveDps(10, width)),
          height: getResponsiveDps(50, width),
          width: getResponsiveDps(162, width),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(getResponsiveDps(7, width)))),
          child: Text(
            this.nombre,
            style: TextStyle(
                fontSize: MyConstants.of(context).midTitleSize,
                fontWeight: MyConstants.of(context).fontMedium,
                color: Colors.white),
          )),
    );

    return GestureDetector(
      onTap: () => onPressed(),
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getResponsiveDps(7, width))),
          elevation: 6,
          child: Container(
            height: getResponsiveDps(199, width),
            width: getResponsiveDps(162, width),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(getResponsiveDps(82, width)))),
            child: Stack(
              children: <Widget>[cardImage, backgroundContainer, txtNombre],
            ),
          )),
    );
  }
}
