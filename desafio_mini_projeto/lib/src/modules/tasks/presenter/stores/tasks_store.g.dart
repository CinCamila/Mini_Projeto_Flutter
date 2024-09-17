// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskStore on _TaskStore, Store {
  late final _$userIdAtom = Atom(name: '_TaskStore.userId', context: context);

  @override
  String? get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(String? value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  late final _$userNameAtom =
      Atom(name: '_TaskStore.userName', context: context);

  @override
  String? get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String? value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  late final _$tasksAtom = Atom(name: '_TaskStore.tasks', context: context);

  @override
  ObservableList<Task> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<Task> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$addAsyncAction = AsyncAction('_TaskStore.add', context: context);

  @override
  Future<void> add(String taskName) {
    return _$addAsyncAction.run(() => super.add(taskName));
  }

  late final _$fetchTasksAsyncAction =
      AsyncAction('_TaskStore.fetchTasks', context: context);

  @override
  Future<void> fetchTasks() {
    return _$fetchTasksAsyncAction.run(() => super.fetchTasks());
  }

  late final _$removeTasksAsyncAction =
      AsyncAction('_TaskStore.removeTasks', context: context);

  @override
  Future<void> removeTasks(String taskId) {
    return _$removeTasksAsyncAction.run(() => super.removeTasks(taskId));
  }

  @override
  String toString() {
    return '''
userId: ${userId},
userName: ${userName},
tasks: ${tasks}
    ''';
  }
}
