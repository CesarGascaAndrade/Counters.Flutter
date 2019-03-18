import 'package:counters/Models/Counter.dart';
import 'package:counters/Repositories/CountersRepository.dart';
import 'package:counters/Repositories/iCounterRepository.dart';
import 'package:counters/Services/iCountersService.dart';

class CountersService implements iCountersService {
  CountersRepository repository;

  CountersService(iCountersRepository repository) {
    this.repository = repository;
  }

  Counter AddNewCounter(String name) {
    Counter counter = Counter(name:name);
    this.repository.Save(counter);

    return counter;
  }

  List<Counter> GetAllCounters() {
    return this.repository.GetAll();
  }

  void DeleteCounter(Counter counter) {
    this.repository.Delete(counter);
  }
  
  void IncrementCounter(Counter counter) {
    counter.count += 1;
    this.repository.Save(counter);
  }
}