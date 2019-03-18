import 'package:counters/Models/Counter.dart';

abstract class iCountersService {
  Counter AddNewCounter(String name);
  List<Counter> GetAllCounters();
  void DeleteCounter(Counter counter);
  void IncrementCounter(Counter counter);
}