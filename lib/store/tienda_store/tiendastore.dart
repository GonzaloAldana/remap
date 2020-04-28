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
    await getMarcadores("tiendas").then((lista) {
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
      changeListaDistanciaMarcadoresIsNotLoading();
    });
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
    await getListaMarcadoresFromAPI();
    await getUbicacionStore();
    await getListaDistanciaMarcadoresFromAPI();
    changeEverythingIsNotLoading();
  }
}
