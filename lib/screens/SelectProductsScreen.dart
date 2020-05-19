import 'package:flutter/material.dart';
import 'package:remap/atoms/button.dart';
import 'package:remap/components/bulletList.dart';
import 'package:remap/utils/constants.dart';

import 'SmartTicketScreen.dart';

class SelectProductscreen extends StatelessWidget {
  const SelectProductscreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<bool> productsSelected = List<bool>();
    List<bool> servicesSelected = List<bool>();

    Function callbackProducts =
        (List<bool> itemsSelected) => {productsSelected = itemsSelected};
    Function callbackServices =
        (List<bool> itemsSelected) => {servicesSelected = itemsSelected};
    Function btnCallBack = () => {
          print(productsSelected + servicesSelected),
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SmartTicketScreen(
                      listaServicios: servicesSelected,
                      listaProductos: productsSelected,
                    )),
          )
        };

    return Container(
        child: CustomScrollView(
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
                BulletList(
                  options: MyConstants.of(context).listaServicios,
                  isSecondary: true,
                  isMultiSelectable: true,
                  callBack: callbackServices,
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
