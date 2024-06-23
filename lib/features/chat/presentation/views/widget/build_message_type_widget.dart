

import 'package:dd/features/chat/presentation/views/widget/is_file.dart';
import 'package:dd/features/chat/presentation/views/widget/is_image.dart';
import 'package:dd/features/chat/presentation/views/widget/is_record.dart';
import 'package:dd/features/chat/presentation/views/widget/is_video.dart';
import 'package:flutter/material.dart';

import '../../../data/model/messages_model.dart';

class BuildMessageTypeWidget extends StatelessWidget {
  const BuildMessageTypeWidget(
      {super.key, required this.messageModel, required this.message});
  final MessageModel messageModel;
  final dynamic message;
  @override
  Widget build(BuildContext context) {
    switch (messageModel.type) {
      case 'MessageType.text':
        return Text(message);
      case 'MessageType.video':
        return IsVideo(
          message: message,
        );
      case 'MessageType.image':
        return IsImage(messageModel: messageModel, message: message);
      case 'MessageType.images':
        return IsImage(messageModel: messageModel, message: message);
      case 'MessageType.record':
        return IsRecord(message: message);
      case 'MessageType.File':
        return IsFile(message: message, messageModel: messageModel);
      default:
        return const Text('message');
    }
  }
}
