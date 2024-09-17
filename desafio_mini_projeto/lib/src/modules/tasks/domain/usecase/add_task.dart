import 'package:desafio_mini_projeto/src/modules/tasks/domain/errors/tasks_error.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/repositories/task_repository.dart';

abstract class IAddTask {
  Future<(ITaskException?, String?)> call(String listName, String userId);
}

class AddTask implements IAddTask {
  late final ITaskRepository _taskRepository;

  AddTask(this._taskRepository);

  @override
  Future<(ITaskException?, String?)> call(
      String listName, String userId) async {
    return await _taskRepository.addTasks(listName, userId);
  }
}
