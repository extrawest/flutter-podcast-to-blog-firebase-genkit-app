import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isUserMessage;
  final String message;

  const ChatBubble({
    required this.isUserMessage,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isUserMessage ? Colors.deepPurple[400] : Colors.deepPurple[100],
        borderRadius: isUserMessage
            ? const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        )
            : const BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Text(
        message,
        textAlign: isUserMessage ? TextAlign.right : TextAlign.left,
      ),
    );
  }
}