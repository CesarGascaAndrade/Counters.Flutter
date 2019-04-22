import 'package:counters/ViewModels/CounterViewModel.dart';
import 'package:counters/ViewModels/CountersViewModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CountersView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CountersState();
  }

}

class CountersState extends State<CountersView>{
@override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child,
          CountersViewModel countersViewModel) {
        var vm = countersViewModel;

        return Scaffold(
          appBar: AppBar(
            title: Text('Counters.Flutter'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: (vm.counters.length < 1)
                ? Center(
                    child: Text("There's no counters yet"),
                  )
                : ListView.builder(
                    itemCount: vm.counters.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ScopedModel(
                        model: vm.counters[index],
                        child: ScopedModelDescendant(
                          builder: (BuildContext context, Widget child,
                              CounterViewModel counterViewModel) {
                            return Dismissible(
                              key: Key(counterViewModel.id.toString()),
                              background: Container(
                                color: Colors.red,
                              ),
                              onDismissed: (DismissDirection direction) {
                                if (direction == DismissDirection.endToStart) {
                                  counterViewModel.deleteCounter();
                                  setState(() {
                                    vm.counters.removeAt(index);
                                  });
                                }
                              },
                              child: Container(
                                child: ListTile(
                                  leading: const Icon(Icons.event_seat),
                                  title: Text(counterViewModel.name),
                                  trailing: SizedBox(
                                    width: 56.0,
                                    child: Row(
                                      children: <Widget>[
                                        Text(counterViewModel.count.toString()),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          tooltip: 'Increase count',
                                          onPressed: () {
                                            counterViewModel.incrementCounter();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print('saddsfadsfasd');
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
