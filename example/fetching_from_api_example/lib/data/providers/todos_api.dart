import 'package:dio/dio.dart';

class TodosApi {
  Future<List<Map<String, dynamic>>> getExampleTodos() async {
    Dio dio = Dio();

    Response response = await dio.get(
      'https://jsonplaceholder.typicode.com/todos',
    );

    return response.data;
  }
}
