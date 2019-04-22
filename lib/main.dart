import 'package:counters/Repositories/CountersRepository.dart';
import 'package:counters/Services/CountersService.dart';
import 'package:counters/ViewModels/CountersViewModel.dart';
import 'package:flutter/material.dart';
import 'package:counters/Views/CountersView.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  CountersViewModel countersViewModel = new CountersViewModel(new CountersService(new CountersRepository()));
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //countersViewModel.initialize();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ScopedModel(
        model: countersViewModel,
        child: CountersView(),
      ),
    );
  }
}
