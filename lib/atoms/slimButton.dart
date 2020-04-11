import 'package:flutter/material.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class SlimButton extends StatefulWidget {
  final String text;
  final Function onPress;

  SlimButton({
    Key key,
    this.text,
    this.onPress,
  }) : super(key: key);

  @override
  _SlimButtonState createState() => _SlimButtonState();
}

class _SlimButtonState extends State<SlimButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MaterialButton(
      minWidth: getResponsiveDps(200, width),
      height: getResponsiveDps(30, width),
      shape: StadiumBorder(),
      textColor: Colors.white,
      elevation: 20,
      color: Theme.of(context).primaryColor,
      child: Text(widget.text,
          style: TextStyle(
              fontSize: MyConstants.of(context).midTitleSize,
              fontWeight: MyConstants.of(context).fontMedium)),
      onPressed: () {
        widget.onPress();
      },
    );
  }
}
