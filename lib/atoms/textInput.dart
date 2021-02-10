import 'package:flutter/material.dart';
import 'package:remap/utils/utils.dart';

class DecoratedTextInput extends StatefulWidget {
  final String labelText;

  DecoratedTextInput({Key key, this.labelText}) : super(key: key);

  @override
  _DecoratedTextInputState createState() => _DecoratedTextInputState();
}

class _DecoratedTextInputState extends State<DecoratedTextInput> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      child: Container(
        width: getResponsiveDps(294, width),
        child: TextField(
          decoration: InputDecoration(labelText: widget.labelText),
        ),
      ),
    );
  }
}
