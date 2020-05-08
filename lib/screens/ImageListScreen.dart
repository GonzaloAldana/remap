import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';

import 'DistanciaMarcadorListGenerator.dart';

class ImageListScreen extends StatelessWidget {
  const ImageListScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TiendaStore tiendaStore = Provider.of<TiendaStore>(context, listen: false);

    return Container(
        child: DistanciaMarcadorListGenerator(
            listaDistanciaMarcador: tiendaStore.listaDistanciaMarcadores));
  }
}
