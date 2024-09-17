import 'package:desafio_mini_projeto/src/modules/auth/domain/errors/user_error.dart';
import 'package:desafio_mini_projeto/src/modules/auth/domain/repositories/user_repository.dart';
import 'package:desafio_mini_projeto/src/modules/auth/infra/proto/user.pb.dart';

abstract class ILoginUser {
  Future<(IUserException?, User?)> call(String username, String password);
}

class LoginUser implements ILoginUser {
  final IUserRepository _userRepository;

  LoginUser(this._userRepository);
  @override
  Future<(IUserException?, User?)> call(
      String username, String password) async {
    return await _userRepository.loginUser(username, password);
  }
}
