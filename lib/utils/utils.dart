import 'package:flutter/material.dart';

double getResponsiveDps(double size, double widthOfScreen) {
  return (widthOfScreen / 375) * size;
}

Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          key: key,
          backgroundColor: Colors.black54,
          children: <Widget>[
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        ),
      );
    },
  );
}
