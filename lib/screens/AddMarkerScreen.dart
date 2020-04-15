import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remap/atoms/button.dart';
import 'package:remap/components/bulletList.dart';
import 'package:remap/utils/constants.dart';
import 'package:latlong/latlong.dart';

class AddMarkerScreen extends StatelessWidget {
  final LatLng pos;

  const AddMarkerScreen({
    Key key,
    this.pos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Agregar tienda"),
    );

    final formKey = GlobalKey<FormState>();
    String _titulo;
    List<bool> productsSelected = List<bool>();
    List<bool> servicesSelected = List<bool>();

    Function callbackProducts =
        (List<bool> itemsSelected) => {productsSelected = itemsSelected};
    Function callbackServices =
        (List<bool> itemsSelected) => {servicesSelected = itemsSelected};
    Function btnCallBack = () => {
          print(productsSelected + servicesSelected),
          if (formKey.currentState.validate())
            {
              formKey.currentState.save(),
              Firestore.instance.collection('tiendas').document().setData({
                'lat': pos.latitude,
                'lon': pos.longitude,
                'nombre': _titulo,
                'productos': productsSelected,
                'servicios': servicesSelected,
                'clientes': 0,
                'imagen':
                    'https://www.prensalibre.com/wp-content/uploads/2018/12/eee060b0-296f-4463-8429-542adef7bb6b.jpg?quality=82&w=760&h=430&crop=1',
                'hora': Timestamp.now()
              })
            }
        };

    return Scaffold(
        appBar: appBar,
        body: Container(
          child: Column(
            children: <Widget>[
              Form(
                key: formKey,
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Nombre:'),
                  validator: (input) =>
                      input.isEmpty ? 'Introduce un Nombre' : null,
                  onSaved: (input) => _titulo = input,
                ),
              ),
              Expanded(
                child: Center(
                  child: BulletList(
                    options: MyConstants.of(context).listaProductos,
                    isSecondary: true,
                    isMultiSelectable: true,
                    callBack: callbackProducts,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: BulletList(
                    options: MyConstants.of(context).listaServicios,
                    isSecondary: true,
                    isMultiSelectable: true,
                    callBack: callbackServices,
                  ),
                ),
              ),
              PrimaryBtn(
                text: 'Agregar nueva tienda',
                onPress: btnCallBack,
              ),
              Container(
                height: 20,
              )
            ],
          ),
        ));
  }
}
