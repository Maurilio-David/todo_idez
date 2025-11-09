import '../../todo.dart';

class TodoRepositoryImpl implements TodoRepository {
final TodoLocalDataSource localDataSource;
TodoRepositoryImpl({required this.localDataSource});


@override
List<Todo> getAll() {
return localDataSource.getTodos();
}


@override
Future<void> saveAll(List<Todo> todos) async {
await localDataSource.saveTodos(todos);
}
}