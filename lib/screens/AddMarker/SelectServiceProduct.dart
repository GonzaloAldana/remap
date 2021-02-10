import 'package:flutter/material.dart';
import 'package:remap/atoms/containerSeparator.dart';
import 'package:remap/components/bulletList.dart';
import 'package:remap/screens/AddMarker/DataContactScreen.dart';
import 'package:remap/utils/constants.dart';
import 'package:latlong/latlong.dart';
import 'package:remap/utils/utils.dart';

class SelectServiceProductScreen extends StatelessWidget {
  final LatLng pos;

  const SelectServiceProductScreen({
    Key key,
    this.pos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productsSelected = <bool>[];
    var servicesSelected = <bool>[];

    var btnOk = IconButton(
      icon: Icon(
        Icons.done,
        color: Colors.white,
      ),
      onPressed: () async {
        if (productsSelected.where((item) => item == true).isNotEmpty ||
            servicesSelected.where((item) => item == true).isNotEmpty) {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DataContactScreen(
                pos: pos,
                productsSelected: productsSelected,
                servicesSelected: servicesSelected,
              ),
            ),
          );
        } else {
          await showMissingDialog(context,
              'Por favor, selecciona los producto o servicios que ofrece la tienda.');
        }
      },
    );

    var btnRegresar = IconButton(
      icon: Icon(
        Icons.keyboard_arrow_left,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );

    var appBar = AppBar(
      title: Text('¿Qué ofrecen?'),
      leading: btnRegresar,
      actions: <Widget>[btnOk],
    );

    Function callbackProducts =
        (List<bool> itemsSelected) => {productsSelected = itemsSelected};

    Function callbackServices =
        (List<bool> itemsSelected) => {servicesSelected = itemsSelected};

    return Scaffold(
        appBar: appBar,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: <Widget>[
                    ContainerSeparator(
                      titulo: 'Productos',
                      child: BulletList(
                        options: MyConstants.of(context).listaProductos,
                        isSecondary: true,
                        isMultiSelectable: true,
                        callBack: callbackProducts,
                      ),
                    ),
                    ContainerSeparator(
                      titulo: 'Servicios',
                      child: BulletList(
                        options: MyConstants.of(context).listaServicios,
                        isSecondary: true,
                        isMultiSelectable: true,
                        callBack: callbackServices,
                      ),
                    ),
                  ],
                )
              ]),
            )
          ],
        ));
  }
}
