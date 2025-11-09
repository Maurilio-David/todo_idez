import '../../todo.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource dataSource;

  TodoRepositoryImpl(this.dataSource);

  @override
  List<Todo> getAll() {
    final models = dataSource.getAll();
    return models.map((m) => m as Todo).toList(); // ou m.toEntity()
  }

  @override
  Future<void> saveAll(List<Todo> todos) async {
    final models = todos
        .map(
          (t) => TodoModel(
            id: t.id,
            title: t.title,
            notes: t.notes,
            createdAt: t.createdAt,
            done: t.done,
          ),
        )
        .toList();

    await dataSource.saveAll(models);
  }
}
