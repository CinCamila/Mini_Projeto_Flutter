import 'dart:typed_data';

import 'package:desafio_mini_projeto/src/modules/auth/infra/proto/user.pb.dart';
import 'package:desafio_mini_projeto/src/modules/auth/domain/errors/user_error.dart';
import 'package:desafio_mini_projeto/src/modules/auth/infra/datasources/register_user_datasource.dart';
import 'package:desafio_mini_projeto/src/utilities/server_routes.dart';
import 'package:http/http.dart' as http;

class RegisterUserDataSource implements IRegisterUserDataSource {
  final http.Client httpClient;

  RegisterUserDataSource({required this.httpClient});

  @override
  Future<String?> registerUser(String username, String password) async {
    try {
      final uri = Uri.parse(ServerRoutes.signup);
      final Uint8List requestBody = _convertToProtobuf(username, password);

      final response = await httpClient.post(
        uri,
        headers: {'Content-Type': 'application/x-protobuf'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final User user = _decodeProtobufResponse(response.bodyBytes);
        return 'Usuário registrado com sucesso: ${user.name}';
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        return 'Erro de requisição: ${response.statusCode}';
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        return 'Erro no servidor: ${response.statusCode}';
      } else {
        return null;
      }
    } catch (e) {
      throw UserException('Não foi possível cadastrar o usuário. $e');
    }
  }

  Uint8List _convertToProtobuf(String username, String password) {
    final user = User()
      ..name = username
      ..password = password;
    return user.writeToBuffer();
  }

  User _decodeProtobufResponse(Uint8List responseBytes) {
    try {
      final user = User.fromBuffer(responseBytes);
      return user;
    } catch (e) {
      throw UserException('Erro ao decodificar a resposta Protobuf: $e');
    }
  }
}
