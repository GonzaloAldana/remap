import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class FaceCard extends StatelessWidget {
  final String nombre;
  final String url;
  final Function onPressed;

  const FaceCard({Key key, this.nombre, this.url, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var border = Radius.circular(getResponsiveDps(82, width));

    var cardImage = CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: getResponsiveDps(81, width),
        width: getResponsiveDps(81, width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(border),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Container(
        child: CircularProgressIndicator(),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(border)),
        height: getResponsiveDps(81, width),
        width: getResponsiveDps(81, width),
      ),
      errorWidget: (context, url, error) => Opacity(
          opacity: 0.1,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(border)),
            height: getResponsiveDps(81, width),
            width: getResponsiveDps(81, width),
          )),
    );

    var txtNombre = Text(
      nombre,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: MyConstants.of(context).midTitleSize,
          fontWeight: MyConstants.of(context).fontMedium,
          color: MyConstants.of(context).colorGray),
    );

    return GestureDetector(
      onTap: () => onPressed(),
      child: Card(
        elevation: 6,
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border.all(width: 1, color: Theme.of(context).accentColor)),
          height: getResponsiveDps(160, width),
          width: getResponsiveDps(164, width),
          child: Column(children: [
            SizedBox(height: getResponsiveDps(18, width)),
            cardImage,
            SizedBox(height: getResponsiveDps(9, width)),
            txtNombre
          ]),
        ),
      ),
    );
  }
}
