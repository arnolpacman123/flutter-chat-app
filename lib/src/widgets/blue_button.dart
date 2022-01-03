import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 2.0, primary: Colors.blue, shape: const StadiumBorder()),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 55.0,
        child: Center(
          child: Text(text, style: const TextStyle(fontSize: 17.0)),
        ),
      ),
    );
  }
}
