import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:remap/atoms/button.dart';
import 'package:remap/components/bulletList.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:remap/utils/constants.dart';
import 'package:latlong/latlong.dart';
import 'package:path/path.dart' as Path;
import 'package:pedantic/pedantic.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ]));
        });
  }
}

class AddMarkerScreen extends StatelessWidget {
  final LatLng pos;

  const AddMarkerScreen({
    Key key,
    this.pos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TiendaStore tiendaStore = Provider.of<TiendaStore>(context, listen: false);

    File image;

    Future uploadFile() async {
      String res;
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('${tiendaStore.countryCode}/${Path.basename(image.path)}}');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      print('File Uploaded');
      await storageReference.getDownloadURL().then((fileURL) {
        res = fileURL;
      });
      return res;
    }

    var appBar = AppBar(
      title: Text("Agregar tienda"),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.add_a_photo),
                              title: Text("Fotografía"),
                              onTap: () async {
                                image = await ImagePicker.pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 50);
                                await Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.image),
                              title: Text("Galería"),
                              onTap: () async {
                                image = await ImagePicker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 50);
                                await Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Icon(
                Icons.add_a_photo,
                size: 26.0,
              ),
            )),
      ],
    );

    final formKey = GlobalKey<FormState>();
    String _titulo;
    List<bool> productsSelected = List<bool>();
    List<bool> servicesSelected = List<bool>();

    Function callbackProducts =
        (List<bool> itemsSelected) => {productsSelected = itemsSelected};

    Function callbackServices =
        (List<bool> itemsSelected) => {servicesSelected = itemsSelected};

    Function btnCallBack = () async => {
          if (formKey.currentState.validate() &&
              image != null &&
              (productsSelected.where((item) => item == true).isNotEmpty ||
                  servicesSelected.where((item) => item == true).isNotEmpty))
            {
              formKey.currentState.save(),
              Firestore.instance
                  .collection(tiendaStore.countryCode)
                  .document()
                  .setData({
                'lat': pos.latitude,
                'lon': pos.longitude,
                'nombre': _titulo,
                'productos': productsSelected,
                'servicios': servicesSelected,
                'clientes': 0,
                'administrativeArea': tiendaStore.administrativeArea,
                'imagen': await uploadFile(),
                'hora': Timestamp.now()
              }),
              await tiendaStore.loadEverything(),
              await Navigator.of(context).pop()
            }
          else
            {
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text('Falta llenar datos de la tienda'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('OK'),
                        onPressed: () async {
                          await Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              )
            }
        };

    final GlobalKey<State> _keyLoader = GlobalKey<State>();

    Future<void> _handleSubmit(BuildContext context) async {
      unawaited(
          Dialogs.showLoadingDialog(context, _keyLoader)); //invoking login
      await btnCallBack();
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
          .pop(); //close the dialoge
    }

    return Scaffold(
        appBar: appBar,
        body: Container(
          child: Column(
            children: <Widget>[
              Form(
                key: formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                      focusColor: Theme.of(context).accentColor,
                      fillColor: Theme.of(context).accentColor,
                      hoverColor: Theme.of(context).accentColor,
                      hintText: "Nombre",
                      prefixIcon: Icon(Icons.text_fields,
                          color: Theme.of(context).accentColor),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
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
                onPress: () => _handleSubmit(context),
              ),
              Container(
                height: 20,
              )
            ],
          ),
        ));
  }
}
