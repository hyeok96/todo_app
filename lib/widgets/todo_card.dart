import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.todoModel});
  final TodoModel todoModel;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todoModel.id.toString()),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: todoModel.completed ? Colors.green.shade100 : null,
          border: todoModel.completed
              ? Border.all(
                  color: Colors.green,
                )
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(
            todoModel.title,
            style: TextStyle(
              color: todoModel.completed ? Colors.green : null,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: todoModel.completed
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : null,
        ),
      ),
    );
  }
}
