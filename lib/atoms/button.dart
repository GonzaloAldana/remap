import 'package:flutter/material.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class PrimaryBtn extends StatefulWidget {
  final String text;
  final Function onPress;

  PrimaryBtn({
    Key key,
    this.text,
    this.onPress,
  }) : super(key: key);

  @override
  _PrimaryBtnState createState() => _PrimaryBtnState();
}

class _PrimaryBtnState extends State<PrimaryBtn> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MaterialButton(
      shape: StadiumBorder(),
      textColor: Colors.white,
      elevation: 20,
      child: SizedBox(
        width: getResponsiveDps(293, width),
        height: getResponsiveDps(56, width),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor
                ],
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(getResponsiveDps(82, width)))),
          child: Center(
            child: Text(widget.text,
                style: TextStyle(
                    fontSize: MyConstants.of(context).titleSize,
                    fontWeight: MyConstants.of(context).fontMedium,
                    color: Colors.white)),
          ),
        ),
      ),
      onPressed: () {
        widget.onPress();
      },
    );
  }
}
