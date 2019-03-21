import 'package:counters/Models/Counter.dart';
import 'package:counters/Services/CountersService.dart';
import 'package:scoped_model/scoped_model.dart';

class CounterViewModel extends Model {
  Counter counter;
  CountersService service;

  CounterViewModel(this.service);

  String get name => this.counter.name;
  set name(String value) {
    if(this.counter.name == value) return;
    this.counter.name = value;
    notifyListeners();
  }

  int get id => this.counter.id;

  int get count => this.counter.count;

  //Increment counter command
  void IncrementCounter() {
    this.service.IncrementCounter(this.counter);
    notifyListeners();
  }

  void DeleteCounter() {
    this.service.DeleteCounter(this.counter);
  }

  void Prepare(Counter counter) {
    this.counter = counter;
  }
}