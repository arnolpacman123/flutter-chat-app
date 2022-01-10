import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/src/services/auth_service.dart';
import 'package:chat_app/src/helpers/mostrar_alerta.dart';
import 'package:chat_app/src/widgets/logo.dart';
import 'package:chat_app/src/widgets/labels.dart';
import 'package:chat_app/src/widgets/custom_input.dart';
import 'package:chat_app/src/widgets/blue_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = 'login-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Logo(title: 'Ingresar'),
                const _Form(),
                Labels(
                  title: '¿No tienes cuenta?',
                  subtitle: '¡Crea una ahora!',
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    'register-page',
                  ),
                ),
                const Text(
                  'Términos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.email_outlined,
            placeholder: 'Correo electrónico',
            textController: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.lock_outlined,
            placeholder: 'Contraseña',
            textController: passwordController,
            isPassword: true,
          ),
          BlueButton(
            text: 'Ingresar',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                    if (loginOk) {
                      // TODO: Conectar a nuestro socket server
                      Navigator.pushReplacementNamed(context, 'usuarios-page');
                    } else {
                      mostrarAlerta(
                        context,
                        'Login incorrecto',
                        'Revise sus credenciales nuevamente',
                      );
                    }
                  },
          ),
        ],
      ),
    );
  }
}
