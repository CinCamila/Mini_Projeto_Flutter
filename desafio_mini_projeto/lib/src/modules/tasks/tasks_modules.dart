import 'package:desafio_mini_projeto/src/modules/tasks/domain/usecase/delete_tasks.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/usecase/get_tasks.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/external/datasource/delete_tasks_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/external/datasource/get_tasks_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/datasources/delete_task_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/datasources/get_tasks_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/usecase/add_task.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/datasources/add_task_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/external/datasource/add_task_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/repositories/task_repository.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/repositories/task_repository.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/presenter/pages/tasks_page.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/presenter/stores/tasks_store.dart';
import 'package:desafio_mini_projeto/src/modules/auth/infra/proto/user.pb.dart';
import 'package:http/http.dart' as http;

//websocket video
import 'package:desafio_mini_projeto/src/modules/tasks/websocket/videostreaming.dart';

class TasksModule extends Module {
  //utilities
  @override
  void binds(i) {
    //utilities
    i.add(http.Client.new);

    //datasource
    i.add<IAddTaskDataSource>(AddTaskDataSource.new);
    i.add<IGetTaskDataSource>(GetTasksDatasource.new);
    i.add<IDeleteTaskDataSource>(DeleteTaskDataSource.new);

    //repositories
    i.add<ITaskRepository>(TaskRepository.new);

    //usecases
    i.add<IAddTask>(AddTask.new);
    i.add<IGetTasks>(GetTasks.new);
    i.add<IDeleteTask>(DeleteTask.new);

    i.addSingleton<TaskStore>(TaskStore.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) {
        final dynamic data = Modular.args.data;
        print('TasksModule: Received arguments: $data'); //

        if (data is User) {
          final String userName = data.name;
          final String userId = data.id;

          return TasksPage(userName: userName, userId: userId);
        } else {
          return const Center(
              child: Text('User data is missing or invalid.')); //
        }
      },
    );

    r.child('/video_stream', child: (context) => const VideoStream());
  }
}
