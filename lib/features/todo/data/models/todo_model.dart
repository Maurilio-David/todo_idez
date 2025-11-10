import '../../todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required super.id,
    required super.title,
    super.notes,
    required super.createdAt,
    super.done,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'notes': notes,
    'createdAt': createdAt.toIso8601String(),
    'done': done,
  };

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      done: map['done'] as bool,
    );
  }

  String toJson() => toMap().toString();

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      TodoModel.fromMap(json);
}
