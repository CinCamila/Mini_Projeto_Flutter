import 'package:desafio_mini_projeto/src/modules/auth/infra/proto/user.pb.dart';

abstract class ILoginUserDataSource {
  Future<User?> sendUser(String username, String password);
}
