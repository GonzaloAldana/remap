import 'package:flutter/material.dart';
import 'package:remap/atoms/containerSeparator.dart';
import 'package:remap/lists/AliadosListGenerator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ContainerSeparator(
              titulo: 'Lo más nuevo',
              child: Container(height: 200, color: Colors.blue),
            ),
            ContainerSeparator(
              titulo: '¿Cómo puedo ayudar?',
              subtitulo: 'Conviértete en un héroe',
              child: Container(height: 200, color: Colors.blue),
            ),
            ContainerSeparator(
              titulo: 'Nuestros aliados',
              subtitulo: 'Conoce quiénes están ayudando al mundo',
              child: AliadosListGenerator(),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
