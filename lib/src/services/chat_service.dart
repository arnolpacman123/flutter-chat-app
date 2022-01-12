import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/src/services/auth_service.dart';
import 'package:chat_app/src/models/mensajes_response.dart';
import 'package:chat_app/src/models/usuario.dart';
import 'package:chat_app/src/global/environment.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final response = await http.get(
      Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken(),
      },
    );
    if (response.statusCode == 200) {
      final mensajesResponse = mensajesResponseFromMap(response.body);
      return mensajesResponse.mensajes;
    }
    return [];
  }
}
