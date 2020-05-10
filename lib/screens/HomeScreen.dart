import 'package:flutter/material.dart';
import 'package:remap/atoms/containerSeparator.dart';
import 'package:remap/lists/AliadosListGenerator.dart';
import 'package:remap/lists/TutorialesListGenerator.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ContainerSeparator(
              child: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: getResponsiveDps(81, width),
                      width: getResponsiveDps(81, width),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(getResponsiveDps(82, width))),
                        image: DecorationImage(
                            image: AssetImage('assets/logo.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Text('Tu despensa inteligente',
                        style: TextStyle(
                            fontSize: MyConstants.of(context).midTitleSize,
                            fontWeight: MyConstants.of(context).fontMedium,
                            color: Colors.black)),
                    Text(
                        'Nos preocupa el comercio informal, la merma de alimentos y la salud de tu familia.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: MyConstants.of(context).midTitleSize,
                            fontWeight: MyConstants.of(context).fontLight,
                            color: Colors.black54))
                  ],
                ),
              ),
            ),
            ContainerSeparator(
              titulo: '¿Cómo puedo ayudar?',
              subtitulo: 'Conviértete en un héroe',
              child: TutorialesListGenerator(),
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
