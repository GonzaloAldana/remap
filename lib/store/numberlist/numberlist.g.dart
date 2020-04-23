// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'numberlist.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NumberList on _NumberList, Store {
  final _$originalItemsAtom = Atom(name: '_NumberList.originalItems');

  @override
  List<String> get originalItems {
    _$originalItemsAtom.context.enforceReadPolicy(_$originalItemsAtom);
    _$originalItemsAtom.reportObserved();
    return super.originalItems;
  }

  @override
  set originalItems(List<String> value) {
    _$originalItemsAtom.context.conditionallyRunInAction(() {
      super.originalItems = value;
      _$originalItemsAtom.reportChanged();
    }, _$originalItemsAtom, name: '${_$originalItemsAtom.name}_set');
  }

  final _$searchResultsAtom = Atom(name: '_NumberList.searchResults');

  @override
  List<String> get searchResults {
    _$searchResultsAtom.context.enforceReadPolicy(_$searchResultsAtom);
    _$searchResultsAtom.reportObserved();
    return super.searchResults;
  }

  @override
  set searchResults(List<String> value) {
    _$searchResultsAtom.context.conditionallyRunInAction(() {
      super.searchResults = value;
      _$searchResultsAtom.reportChanged();
    }, _$searchResultsAtom, name: '${_$searchResultsAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: '_NumberList.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$getnumbersFromAPIAsyncAction = AsyncAction('getnumbersFromAPI');

  @override
  Future<dynamic> getnumbersFromAPI() {
    return _$getnumbersFromAPIAsyncAction.run(() => super.getnumbersFromAPI());
  }

  final _$_NumberListActionController = ActionController(name: '_NumberList');

  @override
  void changeIsLoading() {
    final _$actionInfo = _$_NumberListActionController.startAction();
    try {
      return super.changeIsLoading();
    } finally {
      _$_NumberListActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsNotLoading() {
    final _$actionInfo = _$_NumberListActionController.startAction();
    try {
      return super.changeIsNotLoading();
    } finally {
      _$_NumberListActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterSearchResults(String query) {
    final _$actionInfo = _$_NumberListActionController.startAction();
    try {
      return super.filterSearchResults(query);
    } finally {
      _$_NumberListActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'originalItems: ${originalItems.toString()},searchResults: ${searchResults.toString()},isLoading: ${isLoading.toString()}';
    return '{$string}';
  }
}
