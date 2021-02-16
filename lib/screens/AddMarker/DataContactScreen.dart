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
import 'package:remap/utils/constants.dart';
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
  List<bool> diasSemanaSeleccionados = <bool>[];
  List<bool> serviciosClienteSeleccionado = List<bool>.of([false, false]);
  TiendaStore tiendaStore;

  final picker = ImagePicker();

  final diasSemana = <String>[
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];

  Future<String> uploadFile() async {
    String res;
    var storageReference = FirebaseStorage.instance
        .ref()
        .child('${tiendaStore.countryCode}/${_path.basename(image.path)}}');
    var uploadTask = storageReference.putFile(image);
    await uploadTask.whenComplete(() async {
      await storageReference.getDownloadURL().then((fileURL) {
        res = fileURL;
      });
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    tiendaStore ??= Provider.of<TiendaStore>(context, listen: false);

    Function callbackClient = (List<bool> itemsSelected) =>
        {serviciosClienteSeleccionado = itemsSelected};

    Function callbackServices =
        (List<bool> itemsSelected) => {diasSemanaSeleccionados = itemsSelected};

    var btnOk = IconButton(
      icon: Icon(
        Icons.done,
        color: Colors.white,
      ),
      onPressed: () async {
        var diasSeleccionados =
            List.of(diasSemanaSeleccionados.where((p) => p == true)).length;
        if (nombre == null ||
            telefono == null ||
            telefono == '' ||
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
                        title: Text('Fotografía'),
                        onTap: () async {
                          var file = await picker.getImage(
                              source: ImageSource.camera, imageQuality: 50);
                          image = File(file.path);
                          await Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.image),
                        title: Text('Galería'),
                        onTap: () async {
                          var file = await picker.getImage(
                              source: ImageSource.gallery, imageQuality: 50);
                          image = File(file.path);
                          await Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              }).then((_) async {
            if (image != null) {
              unawaited(showLoadingDialog(context, _keyLoader));
              var cropped = await ImageCropper.cropImage(
                  sourcePath: image.path,
                  androidUiSettings: AndroidUiSettings(
                      toolbarTitle: 'Editar Imagen',
                      toolbarColor: Colors.grey[200]));
              if (cropped != null) {
                image = cropped;
                var urlImage = await uploadFile();

                await FirebaseFirestore.instance
                    .collection(tiendaStore.countryCode)
                    .doc()
                    .set({
                  'lat': widget.pos.latitude,
                  'lon': widget.pos.longitude,
                  'nombre': nombre,
                  'productos': widget.productsSelected,
                  'servicios': widget.servicesSelected,
                  'clientes': 0,
                  'validado': false,
                  'telefono': telefono,
                  'direccion': direccion,
                  'horaApertura': '${horaInicial.hour}:${horaInicial.minute}',
                  'horaCierre': '${horaCierre.hour}:${horaCierre.minute}',
                  'imagen': urlImage,
                  'hora': Timestamp.now(),
                  'registrado': Timestamp.now(),
                  'serviciosCliente': serviciosClienteSeleccionado,
                  'vistos': 0,
                  'compartidos': 0,
                  'contactados': 0
                });
                await showMissingDialog(context,
                    'Tienda registrada. \n\nValidaremos tu información para que aparezca en la plataforma.');
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

    var txtNombre = Container(
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
            hintText: 'Nombre de la tienda',
            prefixIcon: Icon(Icons.format_color_text,
                color: Theme.of(context).accentColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );

    var txtDireccion = Container(
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
            hintText: 'Dirección de la tienda',
            prefixIcon: Icon(Icons.store_mall_directory,
                color: Theme.of(context).accentColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );

    var txtTelefono = Container(
      width: getResponsiveDps(345, width),
      child: TextField(
        keyboardType: TextInputType.phone,
        cursorColor: Theme.of(context).accentColor,
        style: TextStyle(color: Theme.of(context).accentColor),
        onChanged: (value) => setState(() {
          telefono = value;
        }),
        decoration: InputDecoration(
            focusColor: Theme.of(context).accentColor,
            fillColor: Theme.of(context).accentColor,
            hoverColor: Theme.of(context).accentColor,
            hintText: 'Teléfono de la tienda',
            prefixIcon: Icon(Icons.phone, color: Theme.of(context).accentColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );

    var txtHoraInicio = SlimButton(
        text: horaInicial == null
            ? '¿A qué hora abre?'
            : 'Abre a las ${horaInicial.hour.toString().padLeft(2, '0')}:${horaInicial.minute.toString().padLeft(2, '0')} hrs',
        onPress: () async {
          var hora = await showTimePicker(
              context: context, initialTime: TimeOfDay.now());
          setState(() {
            horaInicial = hora;
          });
        });

    var txtHoraFin = SlimButton(
        text: horaCierre == null
            ? '¿A qué hora cierra?'
            : 'Cierra a las ${horaCierre.hour.toString().padLeft(2, '0')}:${horaCierre.minute.toString().padLeft(2, '0')} hrs',
        onPress: () async {
          var hora = await showTimePicker(
              context: context, initialTime: TimeOfDay.now());
          setState(() {
            horaCierre = hora;
          });
          print(horaInicial);
        });

    var opcAtencionCliente = ContainerSeparator(
      titulo: 'Atención al cliente',
      child: BulletList(
        options: MyConstants.of(context).listaServiciosCliente,
        isSecondary: true,
        isMultiSelectable: true,
        callBack: callbackClient,
      ),
    );

    var opcDiasSemana = ContainerSeparator(
      titulo: 'Días de la semana',
      child: BulletList(
        options: diasSemana,
        isSecondary: true,
        isMultiSelectable: true,
        callBack: callbackServices,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                separador,
                txtNombre,
                separador,
                txtDireccion,
                separador,
                txtTelefono,
                separador,
                txtHoraInicio,
                separador,
                txtHoraFin,
                separador,
                opcAtencionCliente,
                separador,
                opcDiasSemana,
                separador
              ],
            ),
          ),
        ),
      ),
    );
  }
}
