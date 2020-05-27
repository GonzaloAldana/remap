import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import 'package:provider/provider.dart';
import 'package:remap/atoms/containerSeparator.dart';
import 'package:remap/atoms/slimButton.dart';
import 'package:remap/components/bulletList.dart';
import 'package:remap/lists/DistanciaMarcadorListGenerator.dart';
import 'package:remap/store/tienda_store/tiendastore.dart';
import 'package:remap/utils/constants.dart';
import 'package:remap/utils/utils.dart';

class ImageListScreen extends StatefulWidget {
  const ImageListScreen({
    Key key,
  }) : super(key: key);

  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  TiendaStore tiendaStore;
  ScrollController _scrollController = ScrollController();
  String _titulo;
  var controller = TextEditingController();
  void filterSearchResults() => tiendaStore.filterSearchResults(_titulo);
  List<bool> productsSelected = List<bool>();
  List<bool> servicesSelected = List<bool>();
  List<bool> servicesClientSelected = List<bool>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (tiendaStore == null) {
      tiendaStore = Provider.of<TiendaStore>(context, listen: false);
    }

    Function callbackProducts =
        (List<bool> itemsSelected) => {productsSelected = itemsSelected};
    Function callbackServices =
        (List<bool> itemsSelected) => {servicesSelected = itemsSelected};
    Function callbackServiceClient =
        (List<bool> itemsSelected) => {servicesClientSelected = itemsSelected};

    Function showFilterDialog = (BuildContext context) => showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                content: Container(
                    height: getResponsiveDps(
                        450, MediaQuery.of(context).size.width),
                    width: getResponsiveDps(
                        300, MediaQuery.of(context).size.width),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: CustomScrollView(
                            slivers: <Widget>[
                              SliverList(
                                delegate: SliverChildListDelegate([
                                  Column(
                                    children: <Widget>[
                                      ContainerSeparator(
                                          titulo: 'Productos',
                                          child: BulletList(
                                            options: MyConstants.of(context)
                                                .listaProductos,
                                            isSecondary: true,
                                            isMultiSelectable: true,
                                            callBack: callbackProducts,
                                          )),
                                      ContainerSeparator(
                                          titulo: 'Servicios',
                                          child: BulletList(
                                            options: MyConstants.of(context)
                                                .listaServicios,
                                            isSecondary: true,
                                            isMultiSelectable: true,
                                            callBack: callbackServices,
                                          )),
                                      ContainerSeparator(
                                          titulo: 'Servicio al cliente',
                                          child: BulletList(
                                            options: MyConstants.of(context)
                                                .listaServiciosCliente,
                                            isSecondary: true,
                                            isMultiSelectable: true,
                                            callBack: callbackServiceClient,
                                          ))
                                    ],
                                  )
                                ]),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SlimButton(
                                text: 'Todos',
                                onPress: () {
                                  productsSelected = List<bool>();
                                  servicesSelected = List<bool>();
                                  tiendaStore.searchAll();
                                  Navigator.of(context).pop();
                                }),
                            SlimButton(
                                text: 'Filtrar',
                                onPress: () async {
                                  await tiendaStore.filterProductServiceResults(
                                      productsSelected,
                                      servicesSelected,
                                      servicesClientSelected);
                                  productsSelected = List<bool>();
                                  servicesSelected = List<bool>();
                                  Navigator.of(context).pop();
                                })
                          ],
                        )
                      ],
                    )));
          },
        );

    var barraBusqueda = TextFormField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(-2),
          focusColor: Theme.of(context).accentColor,
          fillColor: Theme.of(context).accentColor,
          hoverColor: Theme.of(context).accentColor,
          hintText: "Buscar",
          prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                    setState(() {
                      _titulo = '';
                    });
                    tiendaStore.changeResultadoBusquedaIsLoading();
                    Debounce.seconds(3, filterSearchResults);
                  },
                  icon: Icon(Icons.clear),
                )
              : SizedBox.shrink(),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      onChanged: (value) => {
        setState(() {
          _titulo = value;
        }),
        // Esperamos 3 segundos a que el usuario termine de escribir y mandamos hacer la petición
        // Esto sirve para no saturar de peticiones al servidor:
        // Por ejemplo, si escribr "hola", se estarían haciendo 4 peticiones, mejor esperamos a que termine de escribir
        // y que solo se haga una
        tiendaStore.changeResultadoBusquedaIsLoading(),
        Debounce.seconds(3, filterSearchResults)
      },
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
                  onPress: () {
                    showFilterDialog(context);
                  },
                )),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Observer(
            builder: (_) => tiendaStore.resultadoBusquedaIsLoading
                ? Center(child: MyConstants.of(context).progressIndicator)
                : DistanciaMarcadorListGenerator(
                    controller: _scrollController,
                    listaDistanciaMarcador: tiendaStore.resultadoBusqueda),
          )
        ]))
      ],
    ));
  }
}
