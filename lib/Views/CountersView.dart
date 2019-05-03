import 'package:counters/Models/Counter.dart';
import 'package:counters/Repositories/CountersRepository.dart';
import 'package:counters/Services/CountersService.dart';
import 'package:counters/ViewModels/CounterViewModel.dart';
import 'package:counters/ViewModels/CountersViewModel.dart';
import 'package:counters/Views/CounterView.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CountersView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CountersState();
  }
}

class CountersState extends State<CountersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.timer),
          title: Text('Counters.Flutter'),
        ),
        body: ScopedModelDescendant(
          builder: (
            BuildContext context,
            Widget child,
            CountersViewModel countersViewModel,
          ) {
            var vm = countersViewModel;

            return (vm.counters.length < 1)
                ? Center(
                    child: vm.loading
                        ? CircularProgressIndicator()
                        : Text("There's no counters... yet"),
                  )
                : ListView.builder(
                    itemCount: vm.counters.length,
                    itemBuilder: (BuildContext context, int index) {
                      var counter = vm.counters[index];

                      return Dismissible(
                        key: Key(counter.id.toString()),
                        background: Container(
                          color: Colors.green,
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  'Green Text',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  'Remove',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onDismissed: (DismissDirection direction) {
                          if (direction == DismissDirection.endToStart) {
                            setState(() {
                              vm.removeCounter(counter);
                              vm.loadCounters();
                            });
                          }
                        },
                        child: ListTile(
                          //leading: const Icon(Icons.event_seat),
                          title: Container(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        new CounterView(counter),
                                  ),
                                );
                              },
                              child: Text(counter.name),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline),
                                tooltip: 'Increase count',
                                onPressed: () {
                                  vm.decrementCounter(counter);
                                },
                              ),
                              Text(counter.count.toString()),
                              IconButton(
                                icon: Icon(Icons.add_circle_outline),
                                tooltip: 'Increase count',
                                onPressed: () {
                                  vm.incrementCounter(counter);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
        floatingActionButton: ScopedModelDescendant(
          builder: (BuildContext context, Widget child,
              CountersViewModel viewModel) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CounterView(Counter()),
                  ),
                );
              },
              child: Icon(Icons.add),
            );
          },
        ));
  }
}
