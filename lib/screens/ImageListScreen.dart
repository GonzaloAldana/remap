import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remap/atoms/slimButton.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:remap/utils/utils.dart';

import 'DistanciaMarcadorListGenerator.dart';

class ImageListScreen extends StatelessWidget {
  const ImageListScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TiendaStore tiendaStore = Provider.of<TiendaStore>(context, listen: false);
    ScrollController _scrollController = ScrollController();
    final formKey = GlobalKey<FormState>();
    String _titulo;

    var barraBusqueda = Form(
      key: formKey,
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(-2),
            focusColor: Theme.of(context).accentColor,
            fillColor: Theme.of(context).accentColor,
            hoverColor: Theme.of(context).accentColor,
            hintText: "Buscar",
            prefixIcon:
                Icon(Icons.search, color: Theme.of(context).accentColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
        validator: (input) => input.isEmpty ? 'Introduce un Nombre' : null,
        onSaved: (input) => _titulo = input,
      ),
    );

    return Container(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white.withAlpha(200),
          snap: true,
          forceElevated: true,
          floating: true,
          title: barraBusqueda,
          expandedHeight: 2 * kToolbarHeight,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 4.0, horizontal: getResponsiveDps(80, width)),
                child: SlimButton(
                  text: 'Filtrar',
                )),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          DistanciaMarcadorListGenerator(
              controller: _scrollController,
              listaDistanciaMarcador: tiendaStore.listaDistanciaMarcadores)
        ]))
      ],
    ));
  }
}
