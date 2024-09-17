import 'package:desafio_mini_projeto/src/modules/auth/domain/usecase/login_user.dart';
import 'package:desafio_mini_projeto/src/modules/auth/domain/usecase/register_user.dart';
import 'package:desafio_mini_projeto/src/modules/auth/domain/errors/user_error.dart';
import 'package:mobx/mobx.dart';
import 'package:desafio_mini_projeto/src/modules/auth/infra/proto/user.pb.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  String? userId;
  String? userName;
  final ILoginUser loginUser;
  final IRegisterUser registerUser;

  _AuthStore(this.loginUser, this.registerUser);

  @observable
  bool obscurePassword = true;

  @action
  void togglePassButton() {
    obscurePassword = !obscurePassword;
  }

  @action
  Future<User?> login(String username, String password) async {
    try {
      print('AuthStore: Iniciando login para usuário: $username'); //
      final (IUserException? exception, User? response) =
          await loginUser.call(username, password);
      if (exception != null) {
        print('AuthStore: Exceção durante login: ${exception.message}'); //
        throw UserException(exception.message);
      }
      if (response != null) {
        userName = response.name;
        userId = response.id;
        print(
            'AuthStore: Usuário logado: ${response.name}, ID: ${response.id}');
        return response;
      }
      print('AuthStore: Resposta inesperada do loginUser.call'); //
      return null;
    } catch (e) {
      throw UserException('Erro ao tentar fazer o login. $e');
    }
  }

  @action
  void setUserName(String data) {
    userName = data;
  }

  @action
  void getUserId(String data) {
    userId = data;
  }

  @action
  Future<void> register(String username, String password) async {
    try {
      final (IUserException? exception, String? response) =
          await registerUser.call(username, password);
      if (exception != null) {
        print('Erro de registro: ${exception.message}');
      } else if (response != null) {
        print('Registro bem-sucedido: $response');
      }
    } catch (e) {
      print('Erro ao tentar registrar usuário.');
    }
  }
}
