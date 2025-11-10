import '../../../../core/core.dart';
import '../../todo.dart';

class AddTodoParams {
  final Todo todo;
  AddTodoParams(this.todo);
}

class AddTodo implements UseCase<void, AddTodoParams> {
  final TodoRepository repository;
  AddTodo(this.repository);

  @override
  Future<void> call(AddTodoParams params) async {
    final list = repository.getAll();
    final updated = [params.todo, ...list];
    await repository.saveAll(updated);
  }
}
