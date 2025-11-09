import 'package:flutter/material.dart';

import '../../../todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 16),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: todo.done ? Colors.grey.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: onToggle,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: todo.done ? Colors.green : Colors.grey,
                    width: 2,
                  ),
                  color: todo.done
                      ? Colors.greenAccent.withValues(alpha: 0.2)
                      : Colors.transparent,
                ),
                child: todo.done ? Icon(Icons.check, size: 18) : null,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 250),
                style: TextStyle(
                  decoration: todo.done
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: todo.done ? Colors.grey : Colors.black87,
                  fontSize: 16,
                ),
                child: Text(todo.title),
              ),
            ),
            SizedBox(width: 8),
            Text(
              '${todo.createdAt.day}/${todo.createdAt.month}/${todo.createdAt.year.toString().substring(2)}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
