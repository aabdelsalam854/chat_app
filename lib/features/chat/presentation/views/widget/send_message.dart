import 'package:flutter/material.dart';

import '../../../../../core/fire_cloud/fire_cloud.dart';
import '../../../data/model/messages_model.dart';
import '../../../data/model/metadata_model.dart';

class SendMeaasge extends StatelessWidget {
  const SendMeaasge({
    super.key,
    this.controller,
    required this.email,
    required this.type,
    required this.message,
    required this.metadata,
  });
  final TextEditingController? controller;
  final String email;
  final String type;
  final String message;
  final MetadataModel? metadata;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await FireCloud.sendMessage(MessageModel(
          message: message,
          id: email,
          type: type,
          metadata: null,
          time: DateTime.now(),
        ));
        if (controller != null) {
          controller!.clear();
        } else {
          null;
        }
      },
      icon: const Icon(Icons.send),
    );
  }
}
