import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Projetin',
      theme: ThemeData(primarySwatch: Colors.purple),
      routerConfig: Modular.routerConfig,
    );
  }
}
