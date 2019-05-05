import 'package:counters/Models/Counter.dart';
import 'package:counters/Services/CountersService.dart';
import 'package:counters/ViewModels/CounterViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CountersViewModel extends Model {
  List<Counter> counters = List<Counter>();
  CountersService service;
  bool loading = false;

  CountersViewModel(CountersService service) {
    this.service = service;
    initialize();
  }

  void initialize() async {
    loadCounters();
  }

  Future loadCounters() async {
    loading = true;
    this.counters.clear();

    this.counters = await this.service.getAllCounters();

    notifyListeners();
    loading = false;
  }

  CounterViewModel createCounterViewModel(Counter counter) {
    var viewModel = CounterViewModel(service);
    if (counter == null) {
      viewModel.prepare(new Counter());
    } else {
      viewModel.prepare(counter);
    }

    return viewModel;
  }

  Future decrementCounter(Counter counter) {
    counter.count--;
    this.service.saveCounter(counter);
    loadCounters();
  }

  Future incrementCounter(Counter counter) {
    counter.count++;
    this.service.saveCounter(counter);
    loadCounters();
  }

  Future saveCounter(Counter counter) {
    this.service.saveCounter(counter);
    loadCounters();
  }

  Future removeCounter(Counter counter) {
    this.service.deleteCounter(counter);
    notifyListeners();
  }
}
