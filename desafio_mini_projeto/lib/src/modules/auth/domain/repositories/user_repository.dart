import 'package:desafio_mini_projeto/src/modules/auth/domain/errors/user_error.dart';
import 'package:desafio_mini_projeto/src/modules/auth/infra/proto/user.pb.dart';

abstract class IUserRepository {
  Future<(IUserException?, User?)> loginUser(String username, String password);
  Future<(IUserException?, String?)> registerUser(
      String username, String password);
}
