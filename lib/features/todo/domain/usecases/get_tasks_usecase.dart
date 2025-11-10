import '../../../../core/core.dart';
import '../../todo.dart';

class GetTasks implements UseCase<List<Todo>, NoParams> {
  final TodoRepository repository;
  GetTasks(this.repository);

  @override
  Future<List<Todo>> call(NoParams params) async {
    // aqui repository é síncrono; adaptamos para Future
    return Future.value(repository.getAll());
  }
}
