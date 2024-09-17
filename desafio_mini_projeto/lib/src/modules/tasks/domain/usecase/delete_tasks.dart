import 'package:desafio_mini_projeto/src/modules/tasks/domain/errors/tasks_error.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/repositories/task_repository.dart';

abstract class IDeleteTask {
  Future<(ITaskException?, bool?)> call(String taskid);
}

class DeleteTask implements IDeleteTask {
  late final ITaskRepository _taskRepository;

  DeleteTask(this._taskRepository);

  @override
  Future<(ITaskException?, bool?)> call(String taskId) async {
    return await _taskRepository.deleteTasks(taskId);
  }
}
