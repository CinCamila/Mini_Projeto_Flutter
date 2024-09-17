import 'package:desafio_mini_projeto/src/modules/auth/domain/errors/user_error.dart';
import 'package:desafio_mini_projeto/src/modules/auth/domain/repositories/user_repository.dart';

abstract class IRegisterUser {
  Future<(IUserException?, String?)> call(String username, String password);
}

class RegisterUser implements IRegisterUser {
  final IUserRepository _userRepository;

  RegisterUser(this._userRepository);
  @override
  Future<(IUserException?, String?)> call(
      String username, String password) async {
    return await _userRepository.registerUser(username, password);
  }
}
