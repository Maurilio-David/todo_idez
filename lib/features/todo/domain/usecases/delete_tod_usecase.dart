import '../../../../core/core.dart';
import '../../todo.dart';

class DeleteTodoParams {
final String id;
DeleteTodoParams(this.id);
}


class DeleteTodo implements UseCase<void, DeleteTodoParams> {
final TodoRepository repository;
DeleteTodo(this.repository);


@override
Future<void> call(DeleteTodoParams params) async {
final list = repository.getAll();
final updated = list.where((t) => t.id != params.id).toList();
await repository.saveAll(updated);
}
}