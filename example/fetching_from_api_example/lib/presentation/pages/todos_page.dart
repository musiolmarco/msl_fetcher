import 'package:fetching_from_api_example/data/repositories/todos_repository.dart';
import 'package:flutter/material.dart';
import 'package:msl_fetcher/msl_fetcher.dart';

class TodosPage extends StatelessWidget {
  final TodosRepository _todosRepository = TodosRepository();
  TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MslFetcher(
        onDataFetched: () => _todosRepository.getExampleTodosFromApi(),
        dataAvailableWidget: const Text('Data available'),
        fetchingErrorWidget: const Text('Error while fetching...'),
        loadingWidget: const Text('Loading...'),
      ),
    );
  }
}