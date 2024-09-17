import 'package:desafio_mini_projeto/src/modules/tasks/domain/usecase/add_task.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/errors/tasks_error.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/usecase/delete_tasks.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/usecase/get_tasks.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/proto/task.pb.dart';
import 'package:mobx/mobx.dart';

part 'tasks_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  final IAddTask addTask;
  final IGetTasks getTasks;
  final IDeleteTask deleteTask;

  _TaskStore(this.addTask, this.getTasks, this.deleteTask);

  @observable
  String? userId;

  @observable
  String? userName;

  @observable
  ObservableList<Task> tasks = ObservableList<Task>();

  @action
  Future<void> add(String taskName) async {
    try {
      final (ITaskException? exception, String? response) =
          await addTask.call(taskName, userId!);
      if (response != null) {
        print('Task salva com sucesso: $response');
        final newTask = Task()
          ..id = response
          ..task = taskName
          ..userId = userId!;
        tasks.add(newTask);
      } else if (exception != null) {
        print('Erro ao criar task: ${exception.message}');
      }
    } catch (e) {
      print('Erro ao tentar salvar task: $e');
    }
  }

  @action
  Future<void> fetchTasks() async {
    try {
      final (ITaskException? exception, Tasks? taskList) =
          await getTasks.call(userId!);

      if (taskList != null) {
        tasks = ObservableList<Task>.of(taskList.tasks);
      } else if (exception != null) {
        print('Erro ao buscar tasks: ${exception.message}');
      }
    } catch (e) {
      print('Erro ao tentar visualizar tasks: $e');
    }
  }

  @action
  Future<void> removeTasks(String taskId) async {
    try {
      final (ITaskException? exception, _) = await deleteTask.call(taskId);

      if (exception != null) {
        print('Erro ao remover task: ${exception.message}');
      } else {
        tasks.removeWhere((task) => task.id == taskId);
        print('Tarefa removida com sucesso: $taskId');
      }
    } catch (e) {
      print('Erro ao tentar remover task: $e');
    }
  }
}
