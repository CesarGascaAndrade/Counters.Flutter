import 'package:counters/Repositories/CountersRepository.dart';
import 'package:counters/Services/CountersService.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:counters/ViewModels/CountersViewModel.dart';

class MainViewModel extends Model {
  CountersViewModel countersViewModel;
  MainViewModel() {
    countersViewModel = CountersViewModel(
      CountersService(
        CountersRepository(),
      ),
    );
  }
}
