import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../todo.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key, required this.filter});
  final TodoFilter filter;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<TodoFilter>(
      segments: const <ButtonSegment<TodoFilter>>[
        ButtonSegment<TodoFilter>(value: TodoFilter.all, label: Text('Todas')),
        ButtonSegment<TodoFilter>(
          value: TodoFilter.done,
          label: Text('Concluídas'),
        ),
        ButtonSegment<TodoFilter>(
          value: TodoFilter.pending,
          label: Text('Pendente'),
        ),
      ],
      selected: <TodoFilter>{filter},
      onSelectionChanged: (Set<TodoFilter> newSelection) {
        context.read<TodoCubit>().applyFilter(newSelection.first);
      },
    );
  }
}
