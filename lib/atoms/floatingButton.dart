import 'package:flutter/material.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class FloatingButton extends StatefulWidget {
  final double screenWidth;
  final String text;
  final Function onPress;
  FloatingButton({
    Key key,
    this.screenWidth,
    this.text,
    this.onPress,
  }) : super(key: key);

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Opacity(
      opacity: 0.9,
      child: MaterialButton(
        minWidth: getResponsiveDps(146.5, width),
        height: getResponsiveDps(56, width),
        shape: StadiumBorder(),
        textColor: Colors.black,
        elevation: 20,
        color: Theme.of(context).primaryColor,
        child: Text(widget.text,
            style: TextStyle(
              fontSize: MyConstants.of(context).midTitleSize,
              fontWeight: MyConstants.of(context).fontSemiBold,
            )),
        onPressed: () {
          widget.onPress();
        },
      ),
    );
  }
}
