import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:remap/store/counter/counter.dart';

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final Counter counter = Counter();

  @override
  void initState() {
    counter.changeIsLoading();
    counter.getnumberFromAPI();
    counter.changeIsNotLoading();
    super.initState();
  }

  void incrementNumber() {
    counter.changeIsLoading();
    Future.delayed(Duration(seconds: 3), () => {counter.increment()});
    //counter.increment();
    //counter.changeIsNotLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter and MobX'),
      ),
      body: Center(
        child: Observer(
          builder: (_) => counter.isLoading
              ? Text('Cargando')
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Counter',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Observer(
                      builder: (_) => Text('${counter.value}',
                          style: TextStyle(fontSize: 42.0)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton.icon(
                          icon: Icon(Icons.add),
                          label: Text('Add'),
                          onPressed: incrementNumber,
                        ),
                        FlatButton.icon(
                          icon: Icon(Icons.remove),
                          label: Text('Remove'),
                          onPressed: counter.decrement,
                        ),
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
