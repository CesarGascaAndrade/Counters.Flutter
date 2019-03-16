import 'package:counters/Models/Counter.dart';

abstract class iCountersService {
  void AddNewCounter(String name);
  List<Counter> GetAllCounters();
  void DeleteCounter(Counter counter);
  void IncrementCounter(Counter counter);
}