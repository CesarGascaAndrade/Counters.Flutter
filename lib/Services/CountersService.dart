import 'package:counters/Models/Counter.dart';
import 'package:counters/Repositories/CountersRepository.dart';
import 'package:counters/Services/iCountersService.dart';

class CountersService {
  CountersRepository repository;

  CountersService(CountersRepository repository) {
    this.repository = repository;
    initialize();
  }

  void initialize() {}

  Counter AddNewCounter(String name) {
    Counter counter = Counter(name: name);
    //this.repository.Save(counter);

    return counter;
  }

  Future<List<Counter>> getAllCounters() {
    return this.repository.GetAll();
  }

  void saveCounter(Counter counter) {
    this.repository.save(counter);
  }

  void deleteCounter(Counter counter) {
    this.repository.delete(counter);
  }

  void incrementCounter(Counter counter) {
    counter.count += 1;
    this.repository.save(counter);
  }
}
