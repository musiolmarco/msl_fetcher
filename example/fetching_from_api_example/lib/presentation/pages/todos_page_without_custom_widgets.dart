import 'package:fetching_from_api_example/data/models/todo.dart';
import 'package:fetching_from_api_example/data/repositories/todos_repository.dart';
import 'package:fetching_from_api_example/presentation/widgets/todo_list_view.dart';
import 'package:flutter/material.dart';
import 'package:msl_fetcher/msl_fetcher.dart';

class TodosPageWithoutCustomWidgets extends StatelessWidget {
  final TodosRepository _todosRepository = TodosRepository();
  TodosPageWithoutCustomWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: MslFetcher<List<Todo>>(
            fetchData: () => _todosRepository.getExampleTodosFromApi(),
            dataAvailableWidget: (List<Todo> availableData, onRefresh) =>
                TodoListView(
              todos: availableData,
            ),
          ),
        ),
      ),
    );
  }
}
