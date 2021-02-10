import 'package:flutter/material.dart';
import 'package:remap/atoms/button.dart';
import 'package:remap/components/bulletList.dart';
import 'package:remap/utils/constants.dart';

import 'SmartTicketScreen.dart';

class SelectProductscreen extends StatelessWidget {
  const SelectProductscreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productsSelected = <bool>[];

    Function callbackProducts =
        (List<bool> itemsSelected) => {productsSelected = itemsSelected};
    Function btnCallBack = () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SmartTicketScreen(
                      listaProductos: productsSelected,
                    )),
          )
        };

    return Container(
        child: CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              children: <Widget>[
                BulletList(
                  options: MyConstants.of(context).listaProductos,
                  isSecondary: true,
                  isMultiSelectable: true,
                  callBack: callbackProducts,
                ),
                PrimaryBtn(
                  text: 'Generar Recorrido Inteligente',
                  onPress: btnCallBack,
                ),
                Container(
                  height: 20,
                )
              ],
            )
          ]),
        )
      ],
    ));
  }
}
