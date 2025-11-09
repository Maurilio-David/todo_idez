import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../../todo.dart';

abstract class TodoLocalDataSource {
  List<Todo> getAll();
  Future<void> saveAll(List<Todo> todos);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  static const _key = 'CLEAN_TODO_V1';
  final SharedPreferences prefs;

  TodoLocalDataSourceImpl({required this.prefs});

  @override
  List<Todo> getAll() {
    final raw = prefs.getStringList(_key);
    if (raw == null) return [];
    try {
      return raw.map((s) {
        final map = json.decode(s) as Map<String, dynamic>;
        return TodoModel.fromMap(map);
      }).toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveAll(List<Todo> todos) async {
    final raw = todos.map((t) {
      final m = TodoModel(
        id: t.id,
        title: t.title,
        notes: t.notes,
        createdAt: t.createdAt,
        done: t.done,
      );
      return json.encode(m.toMap());
    }).toList();
    final ok = await prefs.setStringList(_key, raw);
    if (!ok) throw CacheException();
  }
}
