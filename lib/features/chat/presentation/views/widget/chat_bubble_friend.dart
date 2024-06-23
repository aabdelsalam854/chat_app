import 'package:flutter/material.dart';

import '../../../data/model/messages_model.dart';
import 'build_message_type_widget.dart';

class ChatBubbleFriend extends StatelessWidget {
  const ChatBubbleFriend(
      {super.key, required this.message, required this.messageModel});
  final dynamic message;
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding:
            const EdgeInsets.only(bottom: 16, top: 16, left: 16, right: 16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(0),
              bottomLeft: Radius.circular(32),
            ),
            color: Color(0xFF44A048)),
        child: BuildMessageTypeWidget(messageModel: messageModel, message: message),
      ),
    );
  }
}
