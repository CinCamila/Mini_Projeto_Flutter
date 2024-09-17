import 'package:desafio_mini_projeto/src/modules/tasks/domain/errors/tasks_error.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/proto/task.pb.dart';

abstract class ITaskRepository {
  Future<(ITaskException?, String?)> addTasks(String listName, String userId);
  Future<(ITaskException?, Tasks?)> getTasks(String userId);
  Future<(ITaskException?, bool?)> deleteTasks(String taskId);
}
