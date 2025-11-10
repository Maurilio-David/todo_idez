import '../../todo.dart';

enum TodoStatus { initial, loading, success, failure }

class TodoState {
  final TodoStatus status;
  final List<Todo> todos;
  final String? message;
  final TodoFilter filter;

  TodoState({
    this.status = TodoStatus.initial,
    this.todos = const [],
    this.message,
    this.filter = TodoFilter.all,
  });

  TodoState copyWith({
    TodoStatus? status,
    List<Todo>? todos,
    String? message,
    TodoFilter? filter,
  }) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      message: message ?? this.message,
      filter: filter ?? this.filter,
    );
  }
}

enum TodoFilter { all, pending, done }
