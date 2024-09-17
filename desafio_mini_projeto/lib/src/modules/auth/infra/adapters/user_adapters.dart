import 'dart:typed_data';
import 'package:desafio_mini_projeto/src/modules/auth/domain/errors/user_error.dart';

import '/src/modules/auth/infra/proto/user.pb.dart';

class UserAdapter {
  static User? fromProto(Uint8List? data) {
    try {
      if (data != null) {
        return User.fromBuffer(data);
      }
      return null;
    } catch (e) {
      throw UserException('UserException, $e');
    }
  }

  static Uint8List protoToData(User data) {
    try {
      return data.writeToBuffer();
    } catch (e) {
      throw UserException('User exception, $e');
    }
  }
}
