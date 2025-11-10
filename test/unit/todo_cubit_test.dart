import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_idez/features/features.dart';

import 'unit.dart';

class MockGet extends Mock implements GetTasks {}

class MockAdd extends Mock implements AddTodo {}

class MockDel extends Mock implements DeleteTodo {}

class MockToggle extends Mock implements ToggleTodo {}

void main() {
  late MockGet mockGet;
  late MockAdd mockAdd;
  late MockDel mockDel;
  late MockToggle mockToggle;
  late TodoCubit cubit;

  setUp(() {
    registerFallbackValue(NoParamsFake());
    registerFallbackValue(AddTodoParamsFake());
    mockGet = MockGet();
    mockAdd = MockAdd();
    mockDel = MockDel();
    mockToggle = MockToggle();

    when(() => mockGet.call(any())).thenAnswer((_) async => <Todo>[]);

    cubit = TodoCubit(
      getTasks: mockGet,
      addTodo: mockAdd,
      deleteTodo: mockDel,
      toggleTodo: mockToggle,
    );
  });

  test('initial state', () {
    expect(cubit.state.status, TodoStatus.initial);
  });

  blocTest<TodoCubit, TodoState>(
    'load emits loading then success',
    build: () {
      when(() => mockGet.call(any())).thenAnswer(
        (_) async => [Todo(id: '1', title: 'x', createdAt: DateTime.now())],
      );
      return cubit;
    },
    act: (c) => c.load(),
    expect: () => [isA<TodoState>(), isA<TodoState>()],
  );

  blocTest<TodoCubit, TodoState>(
    'create calls add and refreshes',
    build: () {
      when(() => mockAdd.call(any())).thenAnswer((_) async {});
      when(() => mockGet.call(any())).thenAnswer(
        (_) async => [Todo(id: '1', title: 'x', createdAt: DateTime.now())],
      );
      return cubit;
    },
    act: (c) async => c.create('x'),
    verify: (_) {
      verify(() => mockAdd.call(any())).called(1);
      verify(() => mockGet.call(any())).called(greaterThan(0));
    },
  );
}
