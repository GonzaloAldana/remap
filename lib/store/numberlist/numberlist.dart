import 'package:mobx/mobx.dart';

// This is our generated file (we'll see this soon!)
part 'numberlist.g.dart';

// We expose this to be used throughout our project
class NumberList = _NumberList with _$NumberList;

// Our store class
abstract class _NumberList with Store {
  // Tenemos 2 listas, una es tooda la información del servidor
  // la otra es el resultado de la búsqueda

  @observable
  List<String> originalItems = List<String>();

  @observable
  List<String> searchResults = List<String>();

  // Mostraremos un indicador de progreso mientras se estén descargando los datos de internet y mientras se hace la búsqueda
  @observable
  bool isLoading = true;

  @action
  void changeIsLoading() {
    isLoading = true;
  }

  @action
  void changeIsNotLoading() {
    isLoading = false;
  }

  @action
  Future getnumbersFromAPI() async {
    changeIsLoading();
    await Future.delayed(
        Duration(seconds: 3),
        () => {
              originalItems = List<String>.generate(10000, (i) => "Item $i"),
              searchResults.clear(),
              searchResults.addAll(originalItems),
              changeIsNotLoading()
            });
  }

  @action
  void filterSearchResults(String query) {
    print(query);
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(originalItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      searchResults.clear();
      searchResults.addAll(dummyListData);
    } else {
      searchResults.clear();
      searchResults.addAll(originalItems);
    }
    changeIsNotLoading();
  }
}
