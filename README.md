# 📝 ToDo IDez

Aplicativo de **lista de tarefas** desenvolvido em **Flutter**, com foco em **arquitetura limpa**, **boas práticas** e **testabilidade**.  
O projeto simula um app escalável, preparado para crescer com novas features e atualizações.

---

## 🚀 Tecnologias utilizadas

| Camada | Tecnologia |
|--------|-------------|
| **Apresentação** | `flutter_bloc`, `go_router`, `shimmer` |
| **Injeção de dependência** | `get_it` |
| **Persistência local** | `shared_preferences` |
| **Arquitetura** | Clean Architecture (Data / Domain / Presentation) |
| **Testes** | `flutter_test`, `mocktail`, `bloc_test` |
| **CI/CD** | GitHub Actions com build de APK e análise de tamanho |

---

📦 **Clean Architecture**  
- `data`: comunicação com fontes de dados locais  
- `domain`: regras de negócio (entities + usecases + repository contracts)  
- `presentation`: interface e lógica de apresentação (Cubit/BLoC)  

---

## ⚙️ Injeção de Dependências

Feita com **GetIt** (`lib/core/injection/injection.dart`):

```dart
final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  sl.registerLazySingleton<TodoLocalDataSource>(() => TodoLocalDataSourceImpl(prefs: sl()));
  sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(localDataSource: sl()));

  sl.registerLazySingleton(() => GetTodos(sl()));
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));
  sl.registerLazySingleton(() => ToggleTodo(sl()));

  sl.registerFactory(() => TodoCubit(
        getTodos: sl(),
        addTodo: sl(),
        deleteTodo: sl(),
        toggleTodo: sl(),
      ));
}

🧭 Navegação com GoRouter

Uma única tela (TodoPage) gerenciada pelo router:

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final cubit = GetIt.I<TodoCubit>();
        return BlocProvider.value(value: cubit, child: const TodoPage());
      },
    ),
  ],
);

✨ Funcionalidades

✅ Criar novas tarefas
✅ Excluir tarefas
✅ Marcar e desmarcar tarefas como concluídas
✅ Filtrar tarefas (todas, pendentes, concluídas)
✅ Animações de criação e exclusão
✅ Efeito shimmer durante o carregamento
✅ Salvamento persistente no SharedPreferences
✅ Testes unitários e de integração
✅ CI com build de APK e análise de tamanho

🧪 Testes

Rodar todos os testes:

flutter test --coverage


Gerar relatório HTML:

genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html


Os testes cobrem:

Cubit (TodoCubit)

UseCases (AddTodo, DeleteTodo, ToggleTodo, GetTodos)

DataSource e Repository

Testes de integração e fallback values mocktail

🤖 CI/CD

O projeto já possui um pipeline em .github/workflows/flutter.yml que:

Faz lint e análise estática

Roda os testes

Gera e analisa o tamanho do APK com:

flutter build apk --analyze-size --target-platform=android-arm64

📱 Build local

Gerar o APK de produção:

flutter build apk --release


Ou com relatório de tamanho:

flutter build apk --analyze-size --target-platform=android-arm64

🧰 Requisitos

Flutter SDK >=3.9.2 <4.0.0

Dart SDK >=3.5.0

Android SDK ou emulador configurado

Git (para CI/CD)

🧠 Autor

Maurílio David
💼 Projeto técnico de demonstração — arquitetura limpa e escalável com Flutter.
