import 'package:mobx/mobx.dart';

// This is our generated file (we'll see this soon!)
part 'counter.g.dart';

// We expose this to be used throughout our project
class Counter = _Counter with _$Counter;

// Our store class
abstract class _Counter with Store {
  @observable
  int value = 1;

  @observable
  bool isLoading = true;

  @action
  void increment() {
    value++;
    changeIsNotLoading();
  }

  @action
  void decrement() {
    value--;
  }

  @action
  void changeIsLoading() {
    isLoading = true;
  }

  @action
  void changeIsNotLoading() {
    isLoading = false;
  }

  @action
  Future getnumberFromAPI() async {
    //changeIsLoading();
    await Future.delayed(Duration(seconds: 3));
    value = 32;
    //changeIsNotLoading();
  }
}
