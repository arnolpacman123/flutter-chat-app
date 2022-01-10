// To parse this JSON data, do
//
//     final authResponse = authResponseFromMap(jsonString);

import 'dart:convert';

import 'package:chat_app/src/models/usuario.dart';

AuthResponse authResponseFromMap(String str) => AuthResponse.fromMap(json.decode(str));

String authResponseToMap(AuthResponse data) => json.encode(data.toMap());

class AuthResponse {
    AuthResponse({
        required this.ok,
        required this.usuario,
        required this.token,
    });

    final bool ok;
    final Usuario usuario;
    final String token;

    factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
        ok: json["ok"],
        usuario: Usuario.fromMap(json["usuario"]),
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "usuario": usuario.toMap(),
        "token": token,
    };
}
