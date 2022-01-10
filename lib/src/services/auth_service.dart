import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_app/src/models/auth_response.dart';
import 'package:chat_app/src/models/usuario.dart';
import 'package:chat_app/src/global/environment.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;
  final _storage = const FlutterSecureStorage();

  // Getters del token de forma estática
  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  bool get autenticando => _autenticando;
  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {
      'email': email,
      'password': password,
    };
    final response = await http.post(
      Uri.parse('${Environment.apiUrl}/login'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    autenticando = false;
    if (response.statusCode == 200) {
      final authResponse = authResponseFromMap(response.body);
      usuario = authResponse.usuario;
      await guardarToken(authResponse.token);
      return true;
    }
    return false;
  }

  Future<bool> register(String nombre, String email, String password) async {
    autenticando = true;
    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };
    final response = await http.post(
      Uri.parse('${Environment.apiUrl}/login/new'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    autenticando = false;
    if (response.statusCode == 200) {
      final authResponse = authResponseFromMap(response.body);
      usuario = authResponse.usuario;
      await guardarToken(authResponse.token);
      return true;
    }
    return false;
  }

  Future<bool> isLoggedIn() async {
    final token = (await _storage.read(key: 'token'));
    final response = await http.get(
      Uri.parse('${Environment.apiUrl}/login/renew'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token ?? '',
      },
    );
    if (response.statusCode == 200) {
      final authResponse = authResponseFromMap(response.body);
      usuario = authResponse.usuario;
      await guardarToken(authResponse.token);
      return true;
    }
    await logout();
    return false;
  }

  Future<void> guardarToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
  }
}
