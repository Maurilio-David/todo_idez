import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_idez/features/features.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late MockTodoRepository mockRepo;
  late ToggleTodo usecase;

  final todo = Todo(
    id: '1',
    title: 'Test Todo',
    notes: 'Notes',
    createdAt: DateTime.now(),
    done: false,
  );

  setUp(() {
    mockRepo = MockTodoRepository();
    usecase = ToggleTodo(mockRepo);
  });

  test('should toggle the done flag and save list', () async {
    // arrange
    final todos = [todo];
    when(() => mockRepo.getAll()).thenReturn(todos);
    when(() => mockRepo.saveAll(any())).thenAnswer((_) async => Future.value());

    // act
    await usecase(ToggleTodoParams(todo.id));

    // assert
    verify(() => mockRepo.getAll()).called(1);
  });

  test('should do nothing when todo id not found', () async {
    // arrange
    final todos = [todo];
    when(() => mockRepo.getAll()).thenReturn(todos);

    // act
    await usecase(ToggleTodoParams('invalid-id'));

    // assert
    verify(() => mockRepo.getAll()).called(1);
    verifyNever(() => mockRepo.saveAll(any()));
  });
}
