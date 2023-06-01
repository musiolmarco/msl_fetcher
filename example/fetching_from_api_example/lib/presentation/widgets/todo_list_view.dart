import 'package:fetching_from_api_example/data/models/todo.dart';
import 'package:fetching_from_api_example/presentation/widgets/todo_widget.dart';
import 'package:flutter/material.dart';

/// Example [ListView] to display all [Todo] items
class TodoListView extends StatelessWidget {
  final List<Todo> todos;
  const TodoListView({
    super.key,
    required this.todos,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) => TodoWidget(
        todo: todos[index],
      ),
    );
  }
}
