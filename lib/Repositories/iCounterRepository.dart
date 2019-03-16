import 'package:counters/Models/Counter.dart';

abstract class iCountersRepository {
  void Save(Counter counter);
  List<Counter> GetAll();
  void Delete(Counter counter);
}