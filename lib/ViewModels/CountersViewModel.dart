import 'package:counters/Models/Counter.dart';
import 'package:counters/Services/CountersService.dart';
import 'package:counters/ViewModels/CounterViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CountersViewModel extends Model {
  List<CounterViewModel> counters;
  CountersService service;

  CountersViewModel(this.service);

  void Initialize() {
    LoadCounters();
  }

  void LoadCounters() {
    this.counters.clear();

    var counters = this.service.GetAllCounters();

    counters.forEach((Counter counter) {
      var viewModel = CounterViewModel(service);
      viewModel.Prepare(counter);
      this.counters.add(viewModel);
    });
  }
}