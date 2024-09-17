import 'package:desafio_mini_projeto/src/utilities/server_routes.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/errors/tasks_error.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/datasources/delete_task_datasource.dart';
import 'package:http/http.dart' as http;

class DeleteTaskDataSource implements IDeleteTaskDataSource {
  final http.Client httpClient;

  DeleteTaskDataSource({required this.httpClient});

  @override
  Future<bool?> deleteTask(String taskId) async {
    try {
      final uri = Uri.parse(ServerRoutes.deletetask);

      final response = await httpClient.delete(
        uri,
        headers: {'id': taskId},
      );

      if (response.statusCode == 200) {
        print('Tarefa excluída com sucesso!');
        return true;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        throw TaskException('Erro de requisição: ${response.statusCode}');
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw TaskException('Erro no servidor: ${response.statusCode}');
      } else {
        throw TaskException('Erro inesperado: ${response.statusCode}');
      }
    } catch (e) {
      throw TaskException('Não foi possível excluir a tarefa. $e');
    }
  }
}
