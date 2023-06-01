import 'package:fetching_from_api_example/data/models/todo.dart';
import 'package:fetching_from_api_example/data/providers/todos_api.dart';

class TodosRepository {
  final TodosApi _todosApi = TodosApi();

  Future<List<Todo>> getExampleTodosFromApi() async {
    List<Todo> todos = [];

    List<Map<String, dynamic>> data = await _todosApi.getExampleTodos();

    for (Map<String, dynamic> todoData in data) {
      todos.add(Todo.fromMap(todoData));
    }

    return todos;
  }
}
