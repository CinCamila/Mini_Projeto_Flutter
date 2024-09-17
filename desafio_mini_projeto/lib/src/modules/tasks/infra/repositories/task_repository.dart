import 'package:desafio_mini_projeto/src/modules/tasks/domain/errors/tasks_error.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/repositories/task_repository.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/datasources/add_task_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/datasources/delete_task_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/datasources/get_tasks_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/adapters/task_adapters.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/proto/task.pb.dart';

class TaskRepository extends ITaskRepository {
  final IAddTaskDataSource _addTaskDataSource;
  final IGetTaskDataSource _getTaskDataSource;
  final IDeleteTaskDataSource _deleteTaskDataSource;

  TaskRepository(this._addTaskDataSource, this._getTaskDataSource,
      this._deleteTaskDataSource);

  @override
  Future<(ITaskException?, String?)> addTasks(
      String listName, String userId) async {
    try {
      final response = await _addTaskDataSource.addTask(listName, userId);
      if (response == null) {
        return (TaskException('Erro ao adicionar a tarefa'), null);
      } else {
        return (null, response);
      }
    } catch (e) {
      return (TaskException('Erro ao adicionar a tarefa: $e'), null);
    }
  }

  @override
  Future<(ITaskException?, Tasks?)> getTasks(String userId) async {
    try {
      final response = await _getTaskDataSource.listTasks(userId);
      if (response.isNotEmpty) {
        final tasks = TaskAdapter.tasksFromProto(response);
        return (null, tasks);
      } else {
        return (null, null);
      }
    } catch (e) {
      return (TaskException('Erro ao listar as tarefas: $e'), null);
    }
  }

  @override
  Future<(ITaskException?, bool?)> deleteTasks(String taskId) async {
    try {
      final response = await _deleteTaskDataSource.deleteTask(taskId);
      if (response == null) {
        return (TaskException('Erro ao adicionar a tarefa'), null);
      } else {
        print('Tarefa excluída com sucesso!');
        return (null, null);
      }
    } catch (e) {
      return (TaskException('Erro ao adicionar a tarefa: $e'), null);
    }
  }
}
