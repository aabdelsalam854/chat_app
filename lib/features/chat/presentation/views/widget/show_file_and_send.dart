import 'dart:io';

import 'package:dd/core/utils/get_file_size.dart';
import 'package:dd/features/chat/presentation/views/widget/build_file_widget.dart';
import 'package:dd/features/chat/presentation/views/widget/send_message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../../core/fire_cloud/fire_cloud.dart';
import '../../../../../core/utils/upload_file_in_firebase.dart';
import '../../../data/model/messages_model.dart';
import '../../../data/model/metadata_model.dart';

class ShowFileBeforeSend extends StatelessWidget {
  const ShowFileBeforeSend({
    super.key,
    this.pickedFile,
    this.email,
  });
  final PlatformFile? pickedFile;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pickedFile!.extension!),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: BuildFileWidget(file: pickedFile),
          ),
          SizedBox(
            height: 60,
            child: GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                final url = await UploadFileInFirebase.uploadFile(
                    File(pickedFile!.path!));
                FireCloud.sendMessage(MessageModel(
                    message: url,
                    id: email!,
                    type: 'MessageType.File',
                    time: DateTime.now(),
                    metadata: MetadataModel(
                      fileName: pickedFile!.name,
                      details: null,
                      fileSize: GetFileSize.getFileSize(pickedFile!.size),
                      fileType: pickedFile!.extension,
                      height: null,
                      width: null,
                    )));
                SendMeaasge(
                    message: url,
                    email: email!,
                    type: 'MessageType.File',
                    metadata: MetadataModel(
                      fileName: pickedFile!.name,
                      details: null,
                      fileSize: GetFileSize.getFileSize(pickedFile!.size),
                      fileType: pickedFile!.extension,
                      height: null,
                      width: null,
                    ));
              },
              child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 30,
                  child: Icon(
                    Icons.send,
                    size: 30,
                  )),
            ),
          )
        ]));
  }
}
