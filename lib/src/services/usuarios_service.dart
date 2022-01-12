import 'package:http/http.dart' as http;

import 'package:chat_app/src/services/auth_service.dart';
import 'package:chat_app/src/models/usuarios_response.dart';
import 'package:chat_app/src/models/usuario.dart';
import 'package:chat_app/src/global/environment.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}/usuarios'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
      );
      final usuariosResponse = usuariosResponseFromMap(response.body);
      return usuariosResponse.usuarios;
    } catch (error) {
      return [];
    }
  }
}
