import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_mini_projeto/src/modules/auth/auth_module.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: LoginModule());
  }
}
