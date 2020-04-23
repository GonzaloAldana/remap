import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import 'package:remap/store/numberList/numberlist.dart';
import 'package:remap/utils/constants.dart';

class SearchScreenMobX extends StatefulWidget {
  SearchScreenMobX({Key key}) : super(key: key);

  @override
  _SearchScreenMobXState createState() => _SearchScreenMobXState();
}

class _SearchScreenMobXState extends State<SearchScreenMobX> {
  TextEditingController editingController = TextEditingController();
  final NumberList numberList = NumberList();

  String valorBusqueda = "";

  @override
  void initState() {
    // Obtenemos datos del servidor
    numberList.getnumbersFromAPI();
    super.initState();
  }

  void filterSearchResults() => numberList.filterSearchResults(valorBusqueda);

  @override
  Widget build(BuildContext context) {
    var barraBusqueda = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        cursorColor: Theme.of(context).accentColor,
        style: TextStyle(color: Theme.of(context).accentColor),
        onChanged: (value) => {
          setState(() {
            valorBusqueda = value;
          }),
          // Esperamos 3 segundos a que el usuario termine de escribir y mandamos hacer la petición
          // Esto sirve para no saturar de peticiones al servidor:
          // Por ejemplo, si escribr "hola", se estarían haciendo 4 peticiones, mejor esperamos a que termine de escribir
          // y que solo se haga una
          numberList.changeIsLoading(),
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
            Observer(
              builder: (_) => Expanded(
                child: numberList.isLoading
                    ? MyConstants.of(context).progressIndicator
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: numberList.searchResults.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('${numberList.searchResults[index]}'),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
