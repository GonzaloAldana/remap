import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:remap/utils/functions.dart';
import 'package:remap/utils/utils.dart';
import 'package:pedantic/pedantic.dart';

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
                GlobalKey<State> _keyLoader = GlobalKey<State>();

                unawaited(showLoadingDialog(context, _keyLoader)); //invokin
                await shareImage(imageUrl);
                Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                    .pop();
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
