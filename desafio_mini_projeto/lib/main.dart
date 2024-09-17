import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:desafio_mini_projeto/src/app_module.dart';
import 'package:desafio_mini_projeto/src/app_widget.dart';

void main() => runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
