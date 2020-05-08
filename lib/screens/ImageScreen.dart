import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:remap/utils/functions.dart';

class ImageScreen extends StatelessWidget {
  final String imageUrl;

  const ImageScreen(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Foto de tienda"),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                await shareImage(imageUrl);
              },
              child: Icon(
                Icons.share,
                size: 26.0,
              ),
            )),
      ],
    );

    return Scaffold(
        appBar: appBar,
        body: Container(
            child: PhotoView(
                imageProvider: CachedNetworkImageProvider(imageUrl))));
  }
}
