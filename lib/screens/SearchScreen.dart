import 'package:flutter/material.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import 'package:remap/utils/constants.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController editingController = TextEditingController();

  // Mostraremos un indicador de progreso mientras se estén descargando los datos de internet y mientras se hace la búsqueda
  bool isLoading = true;

  // Tenemos 2 listas, una es tooda la información del servidor
  // la otra es el resultado de la búsqueda
  var duplicateItems = List<String>();
  var items = List<String>();

  String valorBusqueda = "";

  void _getNames() {
    // Obtenemos datos del servidor
    duplicateItems = List<String>.generate(10000, (i) => "Item $i");
    setState(() {
      // Copiamos esta lista como resultado de la búsqueda
      items.addAll(duplicateItems);
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getNames();
    super.initState();
  }

  void filterSearchResults() {
    print(valorBusqueda);
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (valorBusqueda.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(valorBusqueda)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
        isLoading = false;
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
        isLoading = false;
      });
    }
  }

  void printSeconds() => print(valorBusqueda);
  @override
  Widget build(BuildContext context) {
    var barraBusqueda = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        cursorColor: Theme.of(context).accentColor,
        style: TextStyle(color: Theme.of(context).accentColor),
        onChanged: (value) => {
          setState(() {
            isLoading = true;
            valorBusqueda = value;
          }),
          // Esperamos 3 segundos a que el usuario termine de escribir y mandamos hacer la petición
          // Esto sirve para no saturar de peticiones al servidor:
          // Por ejemplo, si escribr "hola", se estarían haciendo 4 peticiones, mejor esperamos a que termine de escribir
          // y que solo se haga una

          Debounce.seconds(3, filterSearchResults)
        },
        controller: editingController,
        decoration: InputDecoration(
            focusColor: Theme.of(context).accentColor,
            fillColor: Theme.of(context).accentColor,
            hoverColor: Theme.of(context).accentColor,
            hintText: "Search",
            prefixIcon:
                Icon(Icons.search, color: Theme.of(context).accentColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Busqueda'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            barraBusqueda,
            Expanded(
              child: isLoading
                  ? MyConstants.of(context).progressIndicator
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('${items[index]}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
