import 'package:counters/Models/Counter.dart';
import 'package:counters/Services/CountersService.dart';
import 'package:scoped_model/scoped_model.dart';

class CounterViewModel extends Model {
  Counter _counter;
  CountersService service;

  CounterViewModel(this.service);

  String get name => this._counter.name;
  set name(String value) {
    if(this._counter.name == value) return;
    this._counter.name = value;
    notifyListeners();
  }

  int get id => this._counter.id;

  int get count => this._counter.count;

  //Increment counter command
  void incrementCounter() {
    this.service.incrementCounter(this._counter);
    notifyListeners();
  }

  void saveCounter() {
    this.service.saveCounter(this._counter);
    
    notifyListeners();
  }

  void deleteCounter() {
    this.service.deleteCounter(this._counter);
    
    notifyListeners();
  }

  void prepare(Counter counter) {
    this._counter = counter;
    notifyListeners();
  }
}