import 'package:flutter_modular/flutter_modular.dart';

import 'package:desafio_mini_projeto/src/modules/auth/domain/repositories/user_repository.dart';
import 'package:desafio_mini_projeto/src/modules/auth/domain/usecase/login_user.dart';
import 'package:desafio_mini_projeto/src/modules/auth/external/datasource/login_user_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/auth/infra/datasources/login_user_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/auth/external/datasource/register_user_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/auth/domain/usecase/register_user.dart';
import 'package:desafio_mini_projeto/src/modules/auth/infra/datasources/register_user_datasource.dart';
import 'package:desafio_mini_projeto/src/modules/auth/infra/repositories/user_repository.dart';
import 'package:desafio_mini_projeto/src/modules/auth/presenter/pages/login_page.dart';
import 'package:desafio_mini_projeto/src/modules/auth/presenter/pages/signup_page.dart';
import 'package:desafio_mini_projeto/src/modules/auth/presenter/store/auth_store.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/tasks_modules.dart';
import 'package:http/http.dart' as http;

class LoginModule extends Module {
  @override
  void binds(i) {
    //utilities
    i.add(http.Client.new);

    //datasource
    i.add<ILoginUserDataSource>(LoginUserDataSource.new);
    i.add<IRegisterUserDataSource>(RegisterUserDataSource.new);

    //repositories
    i.add<IUserRepository>(UserRepository.new);

    //usecases
    i.add<ILoginUser>(LoginUser.new);
    i.add<IRegisterUser>(RegisterUser.new);

    i.addSingleton<AuthStore>(AuthStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginPage());
    r.child('/sign_up_user', child: (context) => const SignupPage());
    r.module('/tasks', module: TasksModule());
  }
}
