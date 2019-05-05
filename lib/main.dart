import 'package:counters/Repositories/CountersRepository.dart';
import 'package:counters/Services/CountersService.dart';
import 'package:counters/ViewModels/CountersViewModel.dart';
import 'package:flutter/material.dart';
import 'package:counters/Views/CountersView.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  CountersViewModel countersViewModel = new CountersViewModel(
    new CountersService(
      new CountersRepository(),
    ),
  );
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScopedModel(
      model: countersViewModel,
          child: MaterialApp(
        title: 'Counters App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CountersView(),
      ),
    );
  }
}
