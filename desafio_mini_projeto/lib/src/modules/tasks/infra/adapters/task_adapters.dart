import 'dart:typed_data';
import 'package:desafio_mini_projeto/src/modules/tasks/domain/errors/tasks_error.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/infra/proto/task.pb.dart';

class TaskAdapter {
  static Task? fromProto(Uint8List? data, {required String id}) {
    try {
      if (data != null) {
        return Task.fromBuffer(data);
      }
      return null;
    } catch (e) {
      throw TaskException('TaskException, $e');
    }
  }

  static Tasks? tasksFromProto(Uint8List? data) {
    try {
      if (data != null) {
        return Tasks.fromBuffer(data);
      }
      return null;
    } catch (e) {
      throw TaskException('TaskException, $e');
    }
  }

  static Uint8List protoToData(Task data) {
    try {
      return data.writeToBuffer();
    } catch (e) {
      throw TaskException('Task exception, $e');
    }
  }
}
