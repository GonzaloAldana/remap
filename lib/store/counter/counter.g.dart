// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Counter on _Counter, Store {
  final _$valueAtom = Atom(name: '_Counter.value');

  @override
  int get value {
    _$valueAtom.context.enforceReadPolicy(_$valueAtom);
    _$valueAtom.reportObserved();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.context.conditionallyRunInAction(() {
      super.value = value;
      _$valueAtom.reportChanged();
    }, _$valueAtom, name: '${_$valueAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: '_Counter.isLoading');

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

  final _$getnumberFromAPIAsyncAction = AsyncAction('getnumberFromAPI');

  @override
  Future<dynamic> getnumberFromAPI() {
    return _$getnumberFromAPIAsyncAction.run(() => super.getnumberFromAPI());
  }

  final _$_CounterActionController = ActionController(name: '_Counter');

  @override
  void increment() {
    final _$actionInfo = _$_CounterActionController.startAction();
    try {
      return super.increment();
    } finally {
      _$_CounterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrement() {
    final _$actionInfo = _$_CounterActionController.startAction();
    try {
      return super.decrement();
    } finally {
      _$_CounterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsLoading() {
    final _$actionInfo = _$_CounterActionController.startAction();
    try {
      return super.changeIsLoading();
    } finally {
      _$_CounterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsNotLoading() {
    final _$actionInfo = _$_CounterActionController.startAction();
    try {
      return super.changeIsNotLoading();
    } finally {
      _$_CounterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'value: ${value.toString()},isLoading: ${isLoading.toString()}';
    return '{$string}';
  }
}
