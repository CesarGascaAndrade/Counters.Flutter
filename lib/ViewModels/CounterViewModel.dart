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
  void incrementCounter() {
    this.service.incrementCounter(this.counter);
    notifyListeners();
  }

  void deleteCounter() {
    this.service.deleteCounter(this.counter);
    notifyListeners();
  }

  void prepare(Counter counter) {
    this.counter = counter;
    notifyListeners();
  }
}