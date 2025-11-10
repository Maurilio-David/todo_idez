import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/features.dart';

final sl = GetIt.instance; // service locator

Future<void> init() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  // Data sources
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(prefs: sl()),
  );

  // Repository
  sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(sl()));

  // Usecases
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));
  sl.registerLazySingleton(() => ToggleTodo(sl()));

  // Cubit
  sl.registerFactory(
    () => TodoCubit(
      getTasks: sl(),
      addTodo: sl(),
      deleteTodo: sl(),
      toggleTodo: sl(),
    ),
  );
}
