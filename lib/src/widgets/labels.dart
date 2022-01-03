import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({
    Key? key,
    this.onTap,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          // '¿No tienes cuenta?',
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 15.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          child: Text(
            subtitle,
            // '¡Crea una ahora!',
            style: TextStyle(
              color: Colors.blue[600],
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}
