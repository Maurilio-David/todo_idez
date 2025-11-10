import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/core.dart';
import '../../todo.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetTasks getTasks;
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final ToggleTodo toggleTodo;
  final _uuid = Uuid();
  TodoFilter _filter = TodoFilter.all;

  TodoCubit({
    required this.getTasks,
    required this.addTodo,
    required this.deleteTodo,
    required this.toggleTodo,
  }) : super(TodoState());

  Future<void> load() async {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      final list = await getTasks(NoParams());
      emit(state.copyWith(status: TodoStatus.success, todos: list));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.failure, message: e.toString()));
    }
  }

  Future<void> create(String title, {String? notes}) async {
    final t = Todo(
      id: _uuid.v4(),
      title: title,
      notes: notes,
      createdAt: DateTime.now(),
    );
    await addTodo(AddTodoParams(t));
    final list = await getTasks(NoParams());
    emit(state.copyWith(todos: list));
  }

  Future<void> remove(String id) async {
    await deleteTodo(DeleteTodoParams(id));
    final list = await getTasks(NoParams());
    emit(state.copyWith(todos: list));
  }

  Future<void> toggle(String id) async {
    await toggleTodo(ToggleTodoParams(id));
    final list = await getTasks(NoParams());
    emit(state.copyWith(todos: list));
  }

  void applyFilter(TodoFilter f) {
    emit(state.copyWith(filter: f));
  }

  List<Todo> visible() {
    switch (state.filter) {
      case TodoFilter.pending:
        return state.todos.where((t) => !t.done).toList();
      case TodoFilter.done:
        return state.todos.where((t) => t.done).toList();
      case TodoFilter.all:
        return state.todos.toList();
    }
  }
}
