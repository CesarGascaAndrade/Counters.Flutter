import 'package:counters/Models/Counter.dart';
import 'package:counters/Services/CountersService.dart';
import 'package:counters/ViewModels/CounterViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CountersViewModel extends Model {
  List<CounterViewModel> counters = List<CounterViewModel>();
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

    List<Counter> counters = await this.service.getAllCounters();

    
    counters.forEach((Counter counter) {
      var viewModel = CounterViewModel(service);
      viewModel.prepare(counter);
      this.counters.add(viewModel);
    });
    
    notifyListeners();
    loading = false;
  }

  Future removeCounter(CounterViewModel counter) {
    counter.deleteCounter();
  }
}