import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class ImageButton extends StatelessWidget {
  final String texto;
  final IconData icono;
  final String url;
  final bool isBig;
  final Function onPressed;

  const ImageButton(
      {Key key,
      this.texto,
      this.icono,
      this.url,
      this.isBig = true,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height =
        isBig ? getResponsiveDps(172, width) : getResponsiveDps(75, width);

    Widget singleImage = Opacity(
        opacity: 0.5,
        child: CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (context, url) => Container(
            child: CircularProgressIndicator(),
            height: height,
            width: width,
          ),
          errorWidget: (context, url, error) => Opacity(
              opacity: 0.1,
              child: Container(
                decoration:
                    BoxDecoration(color: MyConstants.of(context).colorGray),
                height: height,
                width: width,
              )),
        ));

    var iconContainer = Icon(
      icono,
      color: Theme.of(context).accentColor,
      size: getResponsiveDps(50, width),
    );

    var textContainer = Text(
      texto,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: MyConstants.of(context).midTitleSize,
          color: MyConstants.of(context).colorGray),
    );

    var bigContent = Container(
        height: height,
        width: width,
        child: isBig
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  iconContainer,
                  SizedBox(height: getResponsiveDps(13, width)),
                  textContainer
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  iconContainer,
                  SizedBox(width: getResponsiveDps(50, width)),
                  textContainer
                ],
              ));

    return GestureDetector(
        onTap: () => onPressed(),
        child: Container(
          height: height,
          width: width,
          child: Stack(children: <Widget>[singleImage, bigContent]),
        ));
  }
}
