class Todo {
  final String id;
  final String title;
  final String? notes;
  final DateTime createdAt;
  final bool done;

  Todo({
    required this.id,
    required this.title,
    this.notes,
    required this.createdAt,
    this.done = false,
  });
}
