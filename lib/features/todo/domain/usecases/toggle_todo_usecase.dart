import '../../../../core/core.dart' show UseCase;
import '../domain.dart';

class ToggleTodoParams {
final String id;
ToggleTodoParams(this.id);
}


class ToggleTodo implements UseCase<void, ToggleTodoParams> {
final TodoRepository repository;
ToggleTodo(this.repository);


@override
Future<void> call(ToggleTodoParams params) async {
final list = repository.getAll();
final idx = list.indexWhere((t) => t.id == params.id);
if (idx == -1) return;
final t = list[idx];
final toggled = list.toList();
toggled[idx] = Todo(id: t.id, title: t.title, notes: t.notes, createdAt: t.createdAt, done: !t.done);
await repository.saveAll(toggled);
}
}