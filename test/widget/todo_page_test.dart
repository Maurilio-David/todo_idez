import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_idez/features/features.dart';

void main() {
  testWidgets('full flow widget test', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final local = TodoLocalDataSourceImpl(prefs: prefs);
    final repo = TodoRepositoryImpl(dataSource: local);
    final get = GetTasks(repo);
    final add = AddTodo(repo);
    final del = DeleteTodo(repo);
    final toggle = ToggleTodo(repo);

    await tester.pumpWidget(
      BlocProvider(
        create: (_) => TodoCubit(
          getTasks: get,
          addTodo: add,
          deleteTodo: del,
          toggleTodo: toggle,
        ),
        child: MaterialApp(home: TodoPage()),
      ),
    );

    await tester.pumpAndSettle();

    // open dialog
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Teste');
    await tester.tap(find.text('Criar'));
    await tester.pumpAndSettle();

    expect(find.text('Teste'), findsOneWidget);

    // toggle
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pumpAndSettle();

    // delete
    await tester.drag(find.text('Teste'), Offset(-500, 0));
    await tester.pumpAndSettle();

    expect(find.text('Teste'), findsNothing);
  });
}
