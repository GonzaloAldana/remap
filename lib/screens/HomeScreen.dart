import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remap/atoms/containerSeparator.dart';
import 'package:remap/lists/AliadosListGenerator.dart';
import 'package:remap/lists/TutorialesListGenerator.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);
  static TiendaStore tiendaStore;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    tiendaStore ??= Provider.of<TiendaStore>(context, listen: false);

    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            ContainerSeparator(
              child: Container(
                height: getResponsiveDps(220, width),
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
                    Container(
                      width: getResponsiveDps(280, width),
                      child: Text(
                          'Nos preocupan los pequeños negocios vulnerables, la merma de alimentos y la salud de tu familia.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MyConstants.of(context).midTitleSize,
                              fontWeight: MyConstants.of(context).fontLight,
                              color: Colors.black54)),
                    )
                  ],
                ),
              ),
            ),
            ContainerSeparator(
              titulo: '¿Cómo puedo ayudar?',
              subtitulo: 'Guías de uso de la app',
              child: TutorialesListGenerator(),
            ),
            ContainerSeparator(
              titulo: 'Nuestros aliados',
              subtitulo: 'Conoce quiénes están apoyando esta iniciativa',
              child: AliadosListGenerator(
                aliados: tiendaStore.listaAliados,
              ),
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
