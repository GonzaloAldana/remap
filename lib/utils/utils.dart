import 'package:flutter/material.dart';
import 'package:remap/atoms/slimButton.dart';

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
          child: AlertDialog(
              key: key,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              content: Container(
                  height:
                      getResponsiveDps(200, MediaQuery.of(context).size.width),
                  width:
                      getResponsiveDps(200, MediaQuery.of(context).size.width),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))));
    },
  );
}

Function showMissingDialog = (BuildContext context, String texto) =>
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: Container(
                height:
                    getResponsiveDps(200, MediaQuery.of(context).size.width),
                width: getResponsiveDps(200, MediaQuery.of(context).size.width),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      texto,
                      textAlign: TextAlign.center,
                    ),
                    SlimButton(
                      text: 'Cerrar',
                      onPress: () => Navigator.of(context).pop(),
                    )
                  ],
                )));
      },
    );

Function showLongTextDialog = (BuildContext context, String texto) =>
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: Container(
                height:
                    getResponsiveDps(300, MediaQuery.of(context).size.width),
                width: getResponsiveDps(300, MediaQuery.of(context).size.width),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate([
                              Column(
                                children: <Widget>[
                                  Text(
                                    texto,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )
                            ]),
                          )
                        ],
                      ),
                    ),
                    SlimButton(
                      text: 'Cerrar',
                      onPress: () => Navigator.of(context).pop(),
                    )
                  ],
                )));
      },
    );
