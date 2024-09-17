import 'dart:typed_data';

abstract class IGetTaskDataSource {
  Future<Uint8List> listTasks(String userId);
}
