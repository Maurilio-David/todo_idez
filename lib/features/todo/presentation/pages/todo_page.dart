import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<TodoCubit>().load(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
        actions: [
          PopupMenuButton<TodoFilter>(
            icon: const Icon(Icons.filter_list),
            onSelected: (filter) {
              context.read<TodoCubit>().applyFilter(filter);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: TodoFilter.all, child: Text('Todas')),
              const PopupMenuItem(
                value: TodoFilter.done,
                child: Text('Concluídas'),
              ),
              const PopupMenuItem(
                value: TodoFilter.pending,
                child: Text('Pendentes'),
              ),
            ],
          ),
        ],
      ),

      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state.status == TodoStatus.loading ||
              state.status == TodoStatus.initial) {
            return _shimmerList();
          }

          final list = context.read<TodoCubit>().visible();
          if (list.isEmpty) {
            return Column(
              children: [
                MenuWidget(filter: state.filter),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.filter_list_outlined, size: 70),
                      Text('Nenhuma tarefa disponível'),
                    ],
                  ),
                ),
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                MenuWidget(filter: state.filter),
                SizedBox(height: 8),
                Expanded(
                  child: ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final t = list[i];
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: TodoItem(
                          key: ValueKey(t.id),
                          todo: t,
                          onToggle: () =>
                              context.read<TodoCubit>().toggle(t.id),
                          onDelete: () =>
                              context.read<TodoCubit>().remove(t.id),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await showDialog<String?>(
            context: context,
            builder: (_) => NewTodoDialog(),
          );
          if (title != null && title.trim().isNotEmpty) {
            if (!context.mounted) return;
            await context.read<TodoCubit>().create(title.trim());
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _shimmerList() => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: List.generate(6, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
            ),
          ),
        );
      }),
    ),
  );
}
