// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tiendastore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TiendaStore on _TiendaStore, Store {
  final _$positionAtom = Atom(name: '_TiendaStore.position');

  @override
  Position get position {
    _$positionAtom.context.enforceReadPolicy(_$positionAtom);
    _$positionAtom.reportObserved();
    return super.position;
  }

  @override
  set position(Position value) {
    _$positionAtom.context.conditionallyRunInAction(() {
      super.position = value;
      _$positionAtom.reportChanged();
    }, _$positionAtom, name: '${_$positionAtom.name}_set');
  }

  final _$ubicacionIsLoadingAtom =
      Atom(name: '_TiendaStore.ubicacionIsLoading');

  @override
  bool get ubicacionIsLoading {
    _$ubicacionIsLoadingAtom.context
        .enforceReadPolicy(_$ubicacionIsLoadingAtom);
    _$ubicacionIsLoadingAtom.reportObserved();
    return super.ubicacionIsLoading;
  }

  @override
  set ubicacionIsLoading(bool value) {
    _$ubicacionIsLoadingAtom.context.conditionallyRunInAction(() {
      super.ubicacionIsLoading = value;
      _$ubicacionIsLoadingAtom.reportChanged();
    }, _$ubicacionIsLoadingAtom, name: '${_$ubicacionIsLoadingAtom.name}_set');
  }

  final _$listaMarcadoresAtom = Atom(name: '_TiendaStore.listaMarcadores');

  @override
  List<Marcador> get listaMarcadores {
    _$listaMarcadoresAtom.context.enforceReadPolicy(_$listaMarcadoresAtom);
    _$listaMarcadoresAtom.reportObserved();
    return super.listaMarcadores;
  }

  @override
  set listaMarcadores(List<Marcador> value) {
    _$listaMarcadoresAtom.context.conditionallyRunInAction(() {
      super.listaMarcadores = value;
      _$listaMarcadoresAtom.reportChanged();
    }, _$listaMarcadoresAtom, name: '${_$listaMarcadoresAtom.name}_set');
  }

  final _$listaMarcadoresIsLoadingAtom =
      Atom(name: '_TiendaStore.listaMarcadoresIsLoading');

  @override
  bool get listaMarcadoresIsLoading {
    _$listaMarcadoresIsLoadingAtom.context
        .enforceReadPolicy(_$listaMarcadoresIsLoadingAtom);
    _$listaMarcadoresIsLoadingAtom.reportObserved();
    return super.listaMarcadoresIsLoading;
  }

  @override
  set listaMarcadoresIsLoading(bool value) {
    _$listaMarcadoresIsLoadingAtom.context.conditionallyRunInAction(() {
      super.listaMarcadoresIsLoading = value;
      _$listaMarcadoresIsLoadingAtom.reportChanged();
    }, _$listaMarcadoresIsLoadingAtom,
        name: '${_$listaMarcadoresIsLoadingAtom.name}_set');
  }

  final _$listaDistanciaMarcadoresAtom =
      Atom(name: '_TiendaStore.listaDistanciaMarcadores');

  @override
  List<DistanciaMarcador> get listaDistanciaMarcadores {
    _$listaDistanciaMarcadoresAtom.context
        .enforceReadPolicy(_$listaDistanciaMarcadoresAtom);
    _$listaDistanciaMarcadoresAtom.reportObserved();
    return super.listaDistanciaMarcadores;
  }

  @override
  set listaDistanciaMarcadores(List<DistanciaMarcador> value) {
    _$listaDistanciaMarcadoresAtom.context.conditionallyRunInAction(() {
      super.listaDistanciaMarcadores = value;
      _$listaDistanciaMarcadoresAtom.reportChanged();
    }, _$listaDistanciaMarcadoresAtom,
        name: '${_$listaDistanciaMarcadoresAtom.name}_set');
  }

  final _$listaDistanciaMarcadoresIsLoadingAtom =
      Atom(name: '_TiendaStore.listaDistanciaMarcadoresIsLoading');

  @override
  bool get listaDistanciaMarcadoresIsLoading {
    _$listaDistanciaMarcadoresIsLoadingAtom.context
        .enforceReadPolicy(_$listaDistanciaMarcadoresIsLoadingAtom);
    _$listaDistanciaMarcadoresIsLoadingAtom.reportObserved();
    return super.listaDistanciaMarcadoresIsLoading;
  }

  @override
  set listaDistanciaMarcadoresIsLoading(bool value) {
    _$listaDistanciaMarcadoresIsLoadingAtom.context.conditionallyRunInAction(
        () {
      super.listaDistanciaMarcadoresIsLoading = value;
      _$listaDistanciaMarcadoresIsLoadingAtom.reportChanged();
    }, _$listaDistanciaMarcadoresIsLoadingAtom,
        name: '${_$listaDistanciaMarcadoresIsLoadingAtom.name}_set');
  }

  final _$everythingIsLoadingAtom =
      Atom(name: '_TiendaStore.everythingIsLoading');

  @override
  bool get everythingIsLoading {
    _$everythingIsLoadingAtom.context
        .enforceReadPolicy(_$everythingIsLoadingAtom);
    _$everythingIsLoadingAtom.reportObserved();
    return super.everythingIsLoading;
  }

  @override
  set everythingIsLoading(bool value) {
    _$everythingIsLoadingAtom.context.conditionallyRunInAction(() {
      super.everythingIsLoading = value;
      _$everythingIsLoadingAtom.reportChanged();
    }, _$everythingIsLoadingAtom,
        name: '${_$everythingIsLoadingAtom.name}_set');
  }

  final _$getUbicacionStoreAsyncAction = AsyncAction('getUbicacionStore');

  @override
  Future<dynamic> getUbicacionStore() {
    return _$getUbicacionStoreAsyncAction.run(() => super.getUbicacionStore());
  }

  final _$getListaMarcadoresFromAPIAsyncAction =
      AsyncAction('getListaMarcadoresFromAPI');

  @override
  Future<dynamic> getListaMarcadoresFromAPI() {
    return _$getListaMarcadoresFromAPIAsyncAction
        .run(() => super.getListaMarcadoresFromAPI());
  }

  final _$getListaDistanciaMarcadoresFromAPIAsyncAction =
      AsyncAction('getListaDistanciaMarcadoresFromAPI');

  @override
  Future<dynamic> getListaDistanciaMarcadoresFromAPI() {
    return _$getListaDistanciaMarcadoresFromAPIAsyncAction
        .run(() => super.getListaDistanciaMarcadoresFromAPI());
  }

  final _$loadEverythingAsyncAction = AsyncAction('loadEverything');

  @override
  Future<void> loadEverything() {
    return _$loadEverythingAsyncAction.run(() => super.loadEverything());
  }

  final _$_TiendaStoreActionController = ActionController(name: '_TiendaStore');

  @override
  void changeUbicacionIsLoading() {
    final _$actionInfo = _$_TiendaStoreActionController.startAction();
    try {
      return super.changeUbicacionIsLoading();
    } finally {
      _$_TiendaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeUbicacionIsNotLoading() {
    final _$actionInfo = _$_TiendaStoreActionController.startAction();
    try {
      return super.changeUbicacionIsNotLoading();
    } finally {
      _$_TiendaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeListaMarcadoresIsLoading() {
    final _$actionInfo = _$_TiendaStoreActionController.startAction();
    try {
      return super.changeListaMarcadoresIsLoading();
    } finally {
      _$_TiendaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeListaMarcadoresIsNotLoading() {
    final _$actionInfo = _$_TiendaStoreActionController.startAction();
    try {
      return super.changeListaMarcadoresIsNotLoading();
    } finally {
      _$_TiendaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeListaDistanciaMarcadoresIsLoading() {
    final _$actionInfo = _$_TiendaStoreActionController.startAction();
    try {
      return super.changeListaDistanciaMarcadoresIsLoading();
    } finally {
      _$_TiendaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeListaDistanciaMarcadoresIsNotLoading() {
    final _$actionInfo = _$_TiendaStoreActionController.startAction();
    try {
      return super.changeListaDistanciaMarcadoresIsNotLoading();
    } finally {
      _$_TiendaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeEverythingIsLoading() {
    final _$actionInfo = _$_TiendaStoreActionController.startAction();
    try {
      return super.changeEverythingIsLoading();
    } finally {
      _$_TiendaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeEverythingIsNotLoading() {
    final _$actionInfo = _$_TiendaStoreActionController.startAction();
    try {
      return super.changeEverythingIsNotLoading();
    } finally {
      _$_TiendaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'position: ${position.toString()},ubicacionIsLoading: ${ubicacionIsLoading.toString()},listaMarcadores: ${listaMarcadores.toString()},listaMarcadoresIsLoading: ${listaMarcadoresIsLoading.toString()},listaDistanciaMarcadores: ${listaDistanciaMarcadores.toString()},listaDistanciaMarcadoresIsLoading: ${listaDistanciaMarcadoresIsLoading.toString()},everythingIsLoading: ${everythingIsLoading.toString()}';
    return '{$string}';
  }
}
