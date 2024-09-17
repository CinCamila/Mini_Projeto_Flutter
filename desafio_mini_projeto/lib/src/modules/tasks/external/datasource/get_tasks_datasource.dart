import 'dart:typed_data';
import 'package:desafio_mini_projeto/src/utilities/server_routes.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/errors/tasks_error.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/datasources/get_tasks_datasource.dart';
import 'package:http/http.dart' as http;

class GetTasksDatasource implements IGetTaskDataSource {
  final http.Client httpClient;

  GetTasksDatasource({required this.httpClient});

  @override
  Future<Uint8List> listTasks(String userId) async {
    try {
      final uri = Uri.parse(ServerRoutes.gettasks);

      final response = await httpClient.get(
        uri,
        headers: {'id': userId},
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw TaskException('Erro de requisição: ${response.statusCode}');
      }
    } catch (e) {
      throw TaskException('Não foi possível listar as tarefas. Erro: $e');
    }
  }
}
