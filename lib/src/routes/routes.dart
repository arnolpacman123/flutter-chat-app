import 'package:flutter/material.dart' show Widget, BuildContext;

import 'package:chat_app/src/pages/usuarios_page.dart';
import 'package:chat_app/src/pages/chat_page.dart';
import 'package:chat_app/src/pages/login_page.dart';
import 'package:chat_app/src/pages/register_page.dart';
import 'package:chat_app/src/pages/loading_page.dart';

const String initialRoute = LoadingPage.routeName;

final Map<String, Widget Function(BuildContext)> routes = {
  UsuariosPage.routeName: (_) => const UsuariosPage(),
  ChatPage.routeName: (_) => const ChatPage(),
  LoginPage.routeName: (_) => const LoginPage(),
  RegisterPage.routeName: (_) => const RegisterPage(),
  LoadingPage.routeName: (_) => const LoadingPage(),
};
