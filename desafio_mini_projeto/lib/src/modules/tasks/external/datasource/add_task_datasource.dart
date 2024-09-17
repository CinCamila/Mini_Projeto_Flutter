import 'dart:typed_data';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/proto/task.pb.dart';
import 'package:desafio_mini_projeto/src/utilities/server_routes.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/errors/tasks_error.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/datasources/add_task_datasource.dart';
import 'package:http/http.dart' as http;

class AddTaskDataSource implements IAddTaskDataSource {
  final http.Client httpClient;

  AddTaskDataSource({required this.httpClient});

  @override
  Future<String?> addTask(String listName, String userId) async {
    try {
      final uri = Uri.parse(ServerRoutes.addtask);
      final Uint8List requestBody = _convertToProtobuf(listName, userId);

      final response = await httpClient.post(
        uri,
        headers: {'content-type': 'application/x-protobuf'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        return 'Tarefa adicionada com sucesso!';
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        return 'Erro de requisição: ${response.statusCode}';
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        return 'Erro no servidor: ${response.statusCode}';
      } else {
        return null;
      }
    } catch (e) {
      throw TaskException('Não foi possível adicionar a tarefa. $e');
    }
  }

  Uint8List _convertToProtobuf(String listName, String user) {
    final activity = Task()
      ..task = listName
      ..userId = user;
    return activity.writeToBuffer();
  }
}
