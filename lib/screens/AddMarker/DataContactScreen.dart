import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:remap/atoms/containerSeparator.dart';
import 'package:remap/atoms/slimButton.dart';
import 'package:remap/components/bulletList.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:remap/utils/utils.dart';
import 'package:latlong/latlong.dart';
import 'package:pedantic/pedantic.dart';
import 'package:path/path.dart' as _path;

class DataContactScreen extends StatefulWidget {
  final LatLng pos;
  final List<bool> productsSelected;
  final List<bool> servicesSelected;

  const DataContactScreen(
      {Key key, this.pos, this.productsSelected, this.servicesSelected})
      : super(key: key);

  @override
  _DataContactScreenState createState() => _DataContactScreenState();
}

class _DataContactScreenState extends State<DataContactScreen> {
  String nombre, direccion, telefono;
  File image;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  TimeOfDay horaInicial, horaCierre;
  List<bool> diasSemanaSeleccionados = List<bool>();
  TiendaStore tiendaStore;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    tiendaStore = Provider.of<TiendaStore>(context, listen: false);

    Function callbackServices =
        (List<bool> itemsSelected) => {diasSemanaSeleccionados = itemsSelected};

    const List<String> diasSemana = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo'
    ];

    Future uploadFile() async {
      String res;
      StorageReference storageReference = FirebaseStorage.instance.ref().child(
          '${tiendaStore.countryCode}/${tiendaStore.locality}/${_path.basename(image.path)}}');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      await storageReference.getDownloadURL().then((fileURL) {
        res = fileURL;
      });
      return res;
    }

    var btnOk = IconButton(
      icon: Icon(
        Icons.done,
        color: Colors.white,
      ),
      onPressed: () async {
        int diasSeleccionados =
            List.of(diasSemanaSeleccionados.where((p) => p == true)).length;
        if (nombre == null ||
            telefono == null ||
            direccion == null ||
            horaInicial == null ||
            horaCierre == null ||
            diasSeleccionados == 0) {
          await showMissingDialog(context,
              'Falta llenar algunos campos. \n\nPor favor completa el formulario para poder sumarte a esta plataforma.');
        } else {
          await showModalBottomSheet(
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
                              source: ImageSource.camera, imageQuality: 50);
                          await Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.image),
                        title: Text("Galería"),
                        onTap: () async {
                          image = await ImagePicker.pickImage(
                              source: ImageSource.gallery, imageQuality: 50);
                          await Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              }).then((_) async {
            if (image != null) {
              unawaited(showLoadingDialog(context, _keyLoader));
              File cropped = await ImageCropper.cropImage(
                  sourcePath: image.path,
                  androidUiSettings: AndroidUiSettings(
                      toolbarTitle: 'Editar Imagen',
                      toolbarColor: Colors.grey[200]));
              if (cropped != null) {
                image = cropped;
//TODO: agregar lógica de subida
                await Firestore.instance
                    .collection(tiendaStore.countryCode)
                    .document()
                    .setData({
                  'lat': widget.pos.latitude,
                  'lon': widget.pos.longitude,
                  'nombre': nombre,
                  'productos': widget.productsSelected,
                  'servicios': widget.servicesSelected,
                  'clientes': 0,
                  'administrativeArea': tiendaStore.administrativeArea,
                  'locality': tiendaStore.locality,
                  'validado': false,
                  'telefono': telefono,
                  'direccion': direccion,
                  'horaApertura': horaInicial,
                  'horaCierre': horaCierre,
                  'imagen': await uploadFile(),
                  'hora': Timestamp.now()
                });
                await tiendaStore.loadEverything();
              }

              Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                  .pop();
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          });
        }
      },
    );

    var appBar = AppBar(
      title: Text('Datos contacto'),
      leading: IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: <Widget>[btnOk],
    );

    var separador = SizedBox(height: 15);

    return Scaffold(
      appBar: appBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                separador,
                Container(
                  width: getResponsiveDps(345, width),
                  child: TextField(
                    cursorColor: Theme.of(context).accentColor,
                    style: TextStyle(color: Theme.of(context).accentColor),
                    onChanged: (value) => setState(() {
                      nombre = value;
                    }),
                    decoration: InputDecoration(
                        focusColor: Theme.of(context).accentColor,
                        fillColor: Theme.of(context).accentColor,
                        hoverColor: Theme.of(context).accentColor,
                        hintText: "Nombre de la tienda",
                        prefixIcon: Icon(Icons.format_color_text,
                            color: Theme.of(context).accentColor),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                separador,
                Container(
                  width: getResponsiveDps(345, width),
                  child: TextField(
                    cursorColor: Theme.of(context).accentColor,
                    style: TextStyle(color: Theme.of(context).accentColor),
                    onChanged: (value) => setState(() {
                      direccion = value;
                    }),
                    decoration: InputDecoration(
                        focusColor: Theme.of(context).accentColor,
                        fillColor: Theme.of(context).accentColor,
                        hoverColor: Theme.of(context).accentColor,
                        hintText: "Dirección de la tienda",
                        prefixIcon: Icon(Icons.store_mall_directory,
                            color: Theme.of(context).accentColor),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                separador,
                Container(
                  width: getResponsiveDps(345, width),
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    cursorColor: Theme.of(context).accentColor,
                    style: TextStyle(color: Theme.of(context).accentColor),
                    onChanged: (value) => setState(() {
                      telefono = value;
                    }),
                    decoration: InputDecoration(
                        focusColor: Theme.of(context).accentColor,
                        fillColor: Theme.of(context).accentColor,
                        hoverColor: Theme.of(context).accentColor,
                        hintText: "Teléfono tienda",
                        prefixIcon: Icon(Icons.phone,
                            color: Theme.of(context).accentColor),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                separador,
                SlimButton(
                    text: horaInicial == null
                        ? '¿A qué hora abre?'
                        : 'Abre a las ${horaInicial.hour.toString().padLeft(2, '0')}:${horaInicial.minute.toString().padLeft(2, '0')} hrs',
                    onPress: () async {
                      TimeOfDay hora = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      setState(() {
                        horaInicial = hora;
                      });
                    }),
                separador,
                SlimButton(
                    text: horaCierre == null
                        ? '¿A qué hora cierra?'
                        : 'Cierra a las ${horaCierre.hour.toString().padLeft(2, '0')}:${horaCierre.minute.toString().padLeft(2, '0')} hrs',
                    onPress: () async {
                      TimeOfDay hora = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      setState(() {
                        horaCierre = hora;
                      });
                      print(horaInicial);
                    }),
                separador,
                ContainerSeparator(
                  titulo: 'Días de la semana',
                  child: BulletList(
                    options: diasSemana,
                    isSecondary: true,
                    isMultiSelectable: true,
                    callBack: callbackServices,
                  ),
                ),
                separador
              ],
            ),
          ),
        ),
      ),
    );
  }
}
