import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remap/atoms/slimButton.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  String tema, correo, mensaje;
  List<String> temas = [
    'Algo no funciona',
    'Propón nuevas categorías',
    'Propón nuevos tutoriales',
    'Propón nuevas funciones',
    'Conviértete en Partner',
    'Otros'
  ];
  TiendaStore tiendaStore;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    tiendaStore ??= Provider.of<TiendaStore>(context, listen: false);

    var appBar = AppBar(
      title: Text('Contacto'),
      leading: IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );

    var dropdownTema = Container(
      width: getResponsiveDps(345, width),
      child: DropdownButtonFormField<String>(
        isDense: true,
        validator: (String value) => (value.isEmpty || tema.isEmpty)
            ? 'No se ha seleccionado un tema'
            : null,
        hint: Text(tema ?? 'Selecciona un tema'),
        onChanged: (String opt) => setState(() {
          tema = opt;
        }),
        items: temas.map((String sm) {
          return DropdownMenuItem<String>(
            value: sm,
            child: Text(
              sm,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('¿En qué podemos ayudarte?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MyConstants.of(context).midTitleSize,
                      fontWeight: MyConstants.of(context).fontMedium,
                      color: Colors.black)),
              Container(
                width: getResponsiveDps(345, width),
                child: TextField(
                  cursorColor: Theme.of(context).accentColor,
                  style: TextStyle(color: Theme.of(context).accentColor),
                  onChanged: (value) => {
                    setState(() {
                      correo = value;
                    })
                  },
                  decoration: InputDecoration(
                      focusColor: Theme.of(context).accentColor,
                      fillColor: Theme.of(context).accentColor,
                      hoverColor: Theme.of(context).accentColor,
                      hintText: 'Tu correo (opcional)',
                      prefixIcon: Icon(Icons.alternate_email,
                          color: Theme.of(context).accentColor),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              dropdownTema,
              Container(
                width: getResponsiveDps(345, width),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  onChanged: (value) => {
                    setState(() {
                      mensaje = value;
                    })
                  },
                  decoration: InputDecoration(
                      focusColor: Theme.of(context).accentColor,
                      fillColor: Theme.of(context).accentColor,
                      hoverColor: Theme.of(context).accentColor,
                      hintText: 'Tu mensaje',
                      prefixIcon: Icon(Icons.email,
                          color: Theme.of(context).accentColor),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Container(
                width: getResponsiveDps(200, width),
                child: SlimButton(
                  text: 'Enviar',
                  onPress: () async {
                    if (tema == null || mensaje == null) {
                      await showMissingDialog(context,
                          'Falta llenar algunos campos. \n\nNos interesa conocer tu opinión, por favor completa el formulario para poder escucharte.');
                    } else {
                      await FirebaseFirestore.instance
                          .collection('mensajes')
                          .doc()
                          .set({
                        'lat': tiendaStore.position.latitude,
                        'lon': tiendaStore.position.longitude,
                        'mensaje': mensaje,
                        'correo': correo,
                        'tema': tema,
                        'pais': tiendaStore.countryCode,
                        'respondido': false,
                        'fecha': Timestamp.now()
                      });
                      await showMissingDialog(context,
                          'Mensaje enviado. \n\nTu opinión nos importa, gracias por ayudarnos a darte un mejor servicio.');
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
