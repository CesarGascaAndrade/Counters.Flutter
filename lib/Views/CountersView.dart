import 'package:counters/ViewModels/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CountersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counters.Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[Text('Counters available')],
        ),
      ),
    );
  }
}

Widget countersList() {
  return ScopedModelDescendant(
    builder: (BuildContext context, Widget child, MainViewModel model) {
      var vm = model.countersViewModel;

      return ListView.builder(
        itemCount: vm.counters.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(vm.counters[index].id.toString()),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                //vm.deleteProduct(index);
              }
            },
          );
        },
      );
    },
  );
}
