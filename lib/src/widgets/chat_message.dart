import 'package:chat_app/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key? key,
    required this.uid,
    required this.text,
    required this.animationController,
  }) : super(key: key);

  final String uid;
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
        ),
        child: Container(
          child: uid == authService.usuario.uid ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 5.0, left: 50.0, right: 10.0),
        child: Text(text, style: const TextStyle(color: Colors.white)),
        decoration: BoxDecoration(
          color: const Color(0xFF4D9EF6),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 5.0, right: 50.0, left: 10.0),
        child: Text(text, style: const TextStyle(color: Colors.black87)),
        decoration: BoxDecoration(
          color: const Color(0xFFE4E5E8),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
