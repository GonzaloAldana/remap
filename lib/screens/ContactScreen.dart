import 'package:flutter/material.dart';
import 'package:remap/atoms/slimButton.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String tema;
    List<String> temas = [
      'Algo no funciona',
      'Propón nuevas categorías',
      'Propón nuevos tutoriales',
      'Propón nuevas funciones',
      'Conviértete en Partner',
      'Otros'
    ];

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
        hint: Text(tema == null ? "Selecciona un tema" : temas[0]),
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
      body: Center(
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
                onChanged: (value) => {},
                //controller: editingController,
                decoration: InputDecoration(
                    focusColor: Theme.of(context).accentColor,
                    fillColor: Theme.of(context).accentColor,
                    hoverColor: Theme.of(context).accentColor,
                    hintText: "Tu correo (opcional)",
                    prefixIcon: Icon(Icons.alternate_email,
                        color: Theme.of(context).accentColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            dropdownTema,
            Container(
              width: getResponsiveDps(345, width),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                decoration: InputDecoration(
                    focusColor: Theme.of(context).accentColor,
                    fillColor: Theme.of(context).accentColor,
                    hoverColor: Theme.of(context).accentColor,
                    hintText: "Tu mensaje",
                    prefixIcon:
                        Icon(Icons.email, color: Theme.of(context).accentColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Container(
              width: getResponsiveDps(200, width),
              child: SlimButton(
                text: 'Enviar',
                onPress: null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
