import '../domain.dart';

abstract class TodoRepository {
  List<Todo> getAll();
  Future<void> saveAll(List<Todo> todos);
}
