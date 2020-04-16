import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class ImageCard extends StatelessWidget {
  final String nombre;
  final String url;
  final String secondUrl;
  final String distancia;
  final Function onPressed;

  const ImageCard(
      {Key key,
      this.nombre,
      this.url,
      this.distancia,
      this.secondUrl,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    var border = Radius.circular(getResponsiveDps(7, width));

    Widget txtNombre = Positioned(
      bottom: 0,
      child: Container(
          padding: EdgeInsets.all(getResponsiveDps(10, width)),
          height: getResponsiveDps(distancia != null ? 73 : 46, width),
          width: getResponsiveDps(375, width),
          child: Text(
            this.nombre,
            style: TextStyle(
                fontSize: MyConstants.of(context).midTitleSize,
                fontWeight: MyConstants.of(context).fontMedium,
                color: Colors.white),
          )),
    );

    Widget txtDistancia = distancia != null
        ? Positioned(
            bottom: 0,
            left: 0,
            child: Container(
                height: getResponsiveDps(25, width),
                width: getResponsiveDps(360, width),
                child: Text(
                  this.distancia + ' KM',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: MyConstants.of(context).midTitleSize,
                      fontWeight: MyConstants.of(context).fontMedium,
                      color: Colors.white),
                )),
          )
        : Container();

    Widget backgroundContainer = Positioned(
      bottom: 0,
      child: Container(
        height: getResponsiveDps(distancia != null ? 73 : 46, width),
        width: getResponsiveDps(367.5, width),
        decoration: BoxDecoration(
            color: MyConstants.of(context).colorGray.withOpacity(0.75),
            borderRadius: BorderRadius.vertical(bottom: border)),
      ),
    );

    Widget singleImage = CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: getResponsiveDps(225, width),
        width: getResponsiveDps(375, width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(border),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Container(
        child: CircularProgressIndicator(),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(border)),
        height: getResponsiveDps(225, width),
        width: getResponsiveDps(375, width),
      ),
      errorWidget: (context, url, error) => Opacity(
          opacity: 0.1,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(border)),
            height: getResponsiveDps(225, width),
            width: getResponsiveDps(375, width),
          )),
    );

    Widget secondImage = secondUrl != null
        ? CachedNetworkImage(
            imageUrl: secondUrl,
            imageBuilder: (context, imageProvider) => Container(
              height: getResponsiveDps(225, width),
              width: getResponsiveDps(162, width),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(topLeft: border, bottomLeft: border),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Container(
              child: CircularProgressIndicator(),
              decoration: BoxDecoration(borderRadius: BorderRadius.all(border)),
              height: getResponsiveDps(225, width),
              width: getResponsiveDps(162, width),
            ),
            errorWidget: (context, url, error) => Opacity(
                opacity: 0.1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(border)),
                  height: getResponsiveDps(225, width),
                  width: getResponsiveDps(162, width),
                )),
          )
        : Container();

    return GestureDetector(
      onTap: () => onPressed(),
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getResponsiveDps(7, width))),
          elevation: 6,
          child: Container(
            height: getResponsiveDps(225, width),
            width: getResponsiveDps(375, width),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(getResponsiveDps(82, width)))),
            child: Stack(
              children: <Widget>[
                singleImage,
                secondImage,
                backgroundContainer,
                txtNombre,
                txtDistancia
              ],
            ),
          )),
    );
  }
}
