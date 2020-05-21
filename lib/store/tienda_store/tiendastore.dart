import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:remap/utils/functions.dart';
import 'package:remap/utils/models.dart';

// This is our generated file (we'll see this soon!)
part 'tiendastore.g.dart';

// We expose this to be used throughout our project
class TiendaStore = _TiendaStore with _$TiendaStore;

// Our store class
abstract class _TiendaStore with Store {
  // GPS --------------------------------------------------
  @observable
  Position position;

  @observable
  String countryCode;

  @observable
  String administrativeArea;

  @observable
  String locality;

  @observable
  bool ubicacionIsLoading = true;

  @action
  void changeUbicacionIsLoading() {
    ubicacionIsLoading = true;
  }

  @action
  void changeUbicacionIsNotLoading() {
    ubicacionIsLoading = false;
  }

  @action
  Future getUbicacionStore() async {
    changeUbicacionIsLoading();
    await getPosition().then((pos) {
      position = pos;
      changeUbicacionIsNotLoading();
    });
    await Geolocator().placemarkFromPosition(position).then((placemark) {
      countryCode = placemark[0].isoCountryCode;
      administrativeArea = placemark[0].administrativeArea;
      locality = placemark[0].locality;
    });
  }

  // Lista marcadores --------------------------------------------------
  @observable
  List<Marcador> listaMarcadores = List<Marcador>();

  @observable
  bool listaMarcadoresIsLoading = true;

  @action
  void changeListaMarcadoresIsLoading() {
    listaMarcadoresIsLoading = true;
  }

  @action
  void changeListaMarcadoresIsNotLoading() {
    listaMarcadoresIsLoading = false;
  }

  @action
  Future getListaMarcadoresFromAPI() async {
    changeListaMarcadoresIsLoading();
    await getMarcadores(countryCode, administrativeArea, locality)
        .then((lista) {
      listaMarcadores = lista;
      changeListaMarcadoresIsNotLoading();
    });
  }

  // Lista DistanciaMarcador --------------------------------------------------
  @observable
  List<DistanciaMarcador> listaDistanciaMarcadores = List<DistanciaMarcador>();

  @observable
  bool listaDistanciaMarcadoresIsLoading = true;

  @action
  void changeListaDistanciaMarcadoresIsLoading() {
    listaDistanciaMarcadoresIsLoading = true;
  }

  @action
  void changeListaDistanciaMarcadoresIsNotLoading() {
    listaDistanciaMarcadoresIsLoading = false;
  }

  @action
  Future getListaDistanciaMarcadoresFromAPI() async {
    changeListaDistanciaMarcadoresIsLoading();
    await getDistanciasMarcadores(
            listaMarcadores, position.latitude, position.longitude)
        .then((lista) {
      listaDistanciaMarcadores = lista;
      listaDistanciaMarcadores.sort((a, b) =>
          double.parse(a.distancia).compareTo(double.parse(b.distancia)));
      changeListaDistanciaMarcadoresIsNotLoading();
    });
  }

  // Lista Busqueda --------------------------------------------------
  @observable
  List<DistanciaMarcador> resultadoBusqueda = List<DistanciaMarcador>();

  @observable
  bool resultadoBusquedaIsLoading = false;

  @action
  void changeResultadoBusquedaIsLoading() {
    resultadoBusquedaIsLoading = true;
  }

  @action
  void changeResultadoBusquedaIsNotLoading() {
    resultadoBusquedaIsLoading = false;
  }

  @action
  void filterSearchResults(String query) {
    changeResultadoBusquedaIsLoading();
    if (query.isNotEmpty) {
      List<DistanciaMarcador> dummyListData = List<DistanciaMarcador>();
      listaDistanciaMarcadores.forEach((item) {
        if (item.marcador.nombre.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      resultadoBusqueda.clear();
      resultadoBusqueda.addAll(dummyListData);
    } else {
      resultadoBusqueda.clear();
      resultadoBusqueda.addAll(listaDistanciaMarcadores);
    }
    changeResultadoBusquedaIsNotLoading();
  }

  @action
  void filterProductServiceResults(List<bool> products, List<bool> services,
      List<bool> serviceClient) async {
    changeResultadoBusquedaIsLoading();
    if (products.isNotEmpty ||
        services.isNotEmpty ||
        serviceClient.isNotEmpty) {
      List<DistanciaMarcador> dummyListData = List<DistanciaMarcador>();

      for (DistanciaMarcador item in listaDistanciaMarcadores) {
        int necesarios = 0;

        for (var i = 0;
            i < min(item.marcador.productos.length, products.length);
            i++) {
          if (item.marcador.productos[i] && products[i]) {
            necesarios++;
            break;
          }
        }

        for (var i = 0;
            i < min(item.marcador.servicios.length, services.length);
            i++) {
          if (item.marcador.servicios[i] && services[i]) {
            necesarios++;
            break;
          }
        }

        for (var i = 0;
            i <
                min(item.marcador.serviciosCliente.length,
                    serviceClient.length);
            i++) {
          if (item.marcador.serviciosCliente[i] && serviceClient[i]) {
            necesarios++;
            break;
          }
        }
        if (necesarios > 0) {
          dummyListData.add(item);
        }
      }
      ;

      resultadoBusqueda.clear();
      resultadoBusqueda.addAll(dummyListData);
    } else {
      resultadoBusqueda.clear();
      resultadoBusqueda.addAll(listaDistanciaMarcadores);
    }
    changeResultadoBusquedaIsNotLoading();
  }

  @action
  void searchAll() {
    changeResultadoBusquedaIsLoading();
    resultadoBusqueda.clear();
    resultadoBusqueda.addAll(listaDistanciaMarcadores);

    changeResultadoBusquedaIsNotLoading();
  }

// Todossss---------------------------------------------------------
  @observable
  bool everythingIsLoading = true;

  @action
  void changeEverythingIsLoading() {
    everythingIsLoading = true;
  }

  @action
  void changeEverythingIsNotLoading() {
    everythingIsLoading = false;
  }

  @action
  Future<void> loadEverything() async {
    await getUbicacionStore();
    await getListaMarcadoresFromAPI();
    await getListaDistanciaMarcadoresFromAPI();
    resultadoBusqueda = List.of(listaDistanciaMarcadores);
    changeEverythingIsNotLoading();
  }
}
