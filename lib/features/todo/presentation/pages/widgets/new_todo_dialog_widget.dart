import 'package:flutter/material.dart';

class NewTodoDialog extends StatefulWidget {
  const NewTodoDialog({super.key});

  @override
  State<NewTodoDialog> createState() => NewTodoDialogState();
}

class NewTodoDialogState extends State<NewTodoDialog> {
  final _ctrl = TextEditingController();
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nova tarefa'),
      content: TextField(
        controller: _ctrl,
        autofocus: true,
        decoration: InputDecoration(hintText: 'O que precisa ser feito?'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_ctrl.text),
          child: Text('Criar'),
        ),
      ],
    );
  }
}
