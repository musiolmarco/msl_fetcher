import 'package:fetching_from_api_example/data/models/todo.dart';
import 'package:flutter/material.dart';

/// Example [Widget] for displaying a single todo
class TodoWidget extends StatelessWidget {
  final Todo todo;
  const TodoWidget({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: Checkbox(
        value: todo.completed,
        onChanged: (_) {},
      ),
    );
  }
}
