import 'package:desafio_mini_projeto/src/modules/auth/domain/errors/user_error.dart';
import 'package:desafio_mini_projeto/src/modules/auth/domain/repositories/user_repository.dart';
import 'package:desafio_mini_projeto/src/modules/auth/infra/datasources/login_user_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/auth/infra/datasources/register_user_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/auth/infra/proto/user.pb.dart';

class UserRepository extends IUserRepository {
  final ILoginUserDataSource _loginUserDataSource;
  final IRegisterUserDataSource _registerUserDataSource;

  UserRepository(this._loginUserDataSource, this._registerUserDataSource);

  @override
  Future<(IUserException?, User?)> loginUser(
      String username, String password) async {
    try {
      final response = await _loginUserDataSource.sendUser(username, password);
      if (response == null) {
        return (UserException('Erro ao enviar dados de login'), null);
      } else {
        return (null, response);
      }
    } catch (e) {
      return (UserException('Erro de login: $e'), null);
    }
  }

  @override
  Future<(IUserException?, String?)> registerUser(
      String username, String password) async {
    try {
      final response =
          await _registerUserDataSource.registerUser(username, password);

      if (response == null) {
        return (UserException('Erro ao registrar o usuário'), null);
      } else {
        return (null, response);
      }
    } catch (e) {
      return (UserException('Erro de registro: $e'), null);
    }
  }
}
