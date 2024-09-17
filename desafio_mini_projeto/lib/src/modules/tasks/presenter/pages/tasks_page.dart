import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/presenter/stores/tasks_store.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/proto/task.pb.dart';

class TasksPage extends StatefulWidget {
  final String userName;
  final String userId;
  const TasksPage({
    Key? key,
    required this.userName,
    required this.userId,
  }) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late final TaskStore store;

  @override
  void initState() {
    super.initState();
    store = Modular.get<TaskStore>();
    store.userId = widget.userId;
    store.fetchTasks();
  }

  Future<void> _showAddTaskDialog() async {
    final TextEditingController taskController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Tarefa'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: 'Nome da tarefa'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  store.add(taskController.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          widget.userName,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: 30, color: Colors.white),
            onPressed: _showAddTaskDialog,
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Observer(
        builder: (_) {
          if (store.tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Não há tarefas a serem exibidas.'),
                  const SizedBox(height: 10),
                  IconButton(
                    icon: const Icon(Icons.add, size: 30),
                    onPressed: _showAddTaskDialog,
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: store.tasks.length,
              itemBuilder: (context, index) {
                final task = store.tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(task.task),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _confirmDeleteTask(task.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _confirmDeleteTask(String taskId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir Tarefa'),
          content:
              const Text('Você tem certeza que deseja excluir esta tarefa?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                store.removeTasks(taskId);
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
