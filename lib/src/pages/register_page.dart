import 'package:flutter/material.dart';

import 'package:chat_app/src/widgets/logo.dart';
import 'package:chat_app/src/widgets/labels.dart';
import 'package:chat_app/src/widgets/custom_input.dart';
import 'package:chat_app/src/widgets/blue_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String routeName = 'register-page';

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
                const Logo(title: 'Registro'),
                const _Form(),
                Labels(
                  title: '¿Ya tienes cuenta?',
                  subtitle: '¡Ingresa ahora!',
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    'login-page',
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
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.person_outlined,
            placeholder: 'Nombre',
            textController: nameController,
            keyboardType: TextInputType.name,
          ),
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
            text: 'Registrar',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
