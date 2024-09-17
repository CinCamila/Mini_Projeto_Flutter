import 'package:desafio_mini_projeto/src/modules/tasks/domain/errors/tasks_error.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/repositories/task_repository.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/proto/task.pb.dart';

abstract class IGetTasks {
  Future<(ITaskException?, Tasks?)> call(String userId);
}

class GetTasks implements IGetTasks {
  final ITaskRepository _taskRepository;

  GetTasks(this._taskRepository);

  @override
  Future<(ITaskException?, Tasks?)> call(String userId) async {
    try {
      final (exception, tasks) = await _taskRepository.getTasks(userId);
      if (exception != null) {
        return (exception, null);
      } else {
        return (null, tasks);
      }
    } catch (e, stacktrace) {
      print('Erro ao listar as tarefas: $e\nStacktrace: $stacktrace'); //
      return (TaskException('Erro ao listar as tarefas: $e'), null);
    }
  }
}
