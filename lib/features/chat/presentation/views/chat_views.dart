import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dd/features/chat/presentation/views/widget/chat_bubble_friend.dart';
import 'package:dd/features/chat/presentation/views/widget/chat_puple.dart';
import 'package:dd/features/chat/presentation/views/widget/media_selection.dart';
import 'package:dd/features/chat/presentation/views/widget/send_message.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/fire_cloud/fire_cloud.dart';
import '../../../../core/utils/upload_file_in_firebase.dart';
import '../../../login/presentation/views/widget/custom_text_form_field.dart';
import '../../data/model/messages_model.dart';
import 'widget/timer_widget.dart';

class ChatView extends StatefulWidget {
  const ChatView(this.email, {super.key, this.cameras});
  final String email;
  final List<CameraDescription>? cameras;
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController textVontroller = TextEditingController();
  CollectionReference message =
      FirebaseFirestore.instance.collection("messages");
  bool isRecording = false;
  bool isEmpty = true;
  final controller = ScrollController();
  late AudioRecorder record;
  final timeCountroller = TimeController();

  @override
  void initState() {
    super.initState();
    record = AudioRecorder();
  }

  @override
  void dispose() {
    textVontroller.dispose();
    controller.dispose();

    super.dispose();
  }

  controlr() {
    controller.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void startRecord() async {
    final location = await getApplicationDocumentsDirectory();
    final name = const Uuid().v1();
    if (await record.hasPermission()) {
      await record.start(const RecordConfig(),
          path: '${location.path}/$name.m4a');
    }
    timeCountroller.startTimer();
    debugPrint('start record');
  }

  void stopRecord() async {
    final finalPath = await record.stop();
    setState(() {
      isRecording = false;
    });
    timeCountroller.stopTimer();
    final url = await UploadFileInFirebase.uploadFile(File(finalPath!));
    await FireCloud.sendMessage(
      MessageModel(
        metadata: null,
        message: url,
        id: widget.email,
        time: DateTime.now(),
        type: 'MessageType.record',
      ),
    );

    // stopwatch.reset();
    log('File uploaded to $url');
    debugPrint(finalPath);
    debugPrint('stop Record');
  }

  void resumeRecord() async {
    await record.resume();
    timeCountroller.resumeTimer();

    debugPrint('resumeRecord');
  }

  void pauseRecord() async {
    await record.pause();
    timeCountroller.pauseTimer();
    debugPrint('pauseRecord');
  }

  void dipose() {
    record.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FireCloud.getMessages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messagesList = snapshot.data!.docs
                .map((doc) =>
                    MessageModel.fromJson(doc.data() as Map<String, dynamic>))
                .toList();
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: controller,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == widget.email
                              ? ChatBubble(
                                  messageModel: messagesList[index],
                                  message: messagesList[index].message,
                                )
                              : ChatBubbleFriend(
                                  message: messagesList[index].message,
                                  messageModel: messagesList[index]);
                        },
                        itemCount: messagesList.length,
                      ),
                    ),
                    Row(
                      children: [
                        isEmpty
                            ? recorder(context)
                            : SendMeaasge(
                                metadata: null,
                                type: 'MessageType.text',
                                message: textVontroller.text,
                                controller: textVontroller,
                                email: widget.email),
                        Expanded(
                          child: CustomTextFormField(
                            prefixIcon: IconButton(
                              onPressed: () {
                                showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return MediaSelection(email: widget.email);
                                  },
                                );
                              },
                              icon: const Icon(Icons.add),
                            ),
                            controller: textVontroller,
                            hintText: 'Type a message',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text('Loading');
          }
        },
      ),
    );
  }

  GestureDetector recorder(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            startRecord();
                            setState(() {
                              isRecording = true;
                            });
                            if (isRecording = true) {
                            } else {
                              timeCountroller.stopTimer();
                            }
                          },
                          icon: const Icon(Icons.mic)),
                      IconButton(
                          onPressed: () {
                            pauseRecord();
                          },
                          icon: const Icon(Icons.pause)),
                      IconButton(
                          onPressed: () {
                            resumeRecord();
                          },
                          icon: const Icon(Icons.play_arrow)),
                      IconButton(
                          onPressed: () {
                            stopRecord();
                            setState(() {
                              isRecording = false;
                            });
                          },
                          icon: const Icon(Icons.stop)),
                      TimerWidget(
                        controller: timeCountroller,
                      ),
                    ],
                  ),
                );
              });
        },
        child: isRecording ? const Icon(Icons.stop) : const Icon(Icons.mic));
  }
}
             //     TextField(
                        //   controller: textVontroller,
                        //   maxLines: 5,
                        //   minLines: 1,
                        //   decoration: InputDecoration(
                        //     suffixIcon: const Icon(Icons.add),
                        //     hintText: 'Type a message',
                        //     hintStyle:
                        //         const TextStyle(color: Color(0xFF424243)),
                        //     enabledBorder: const OutlineInputBorder(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(16)),
                        //         borderSide:
                        //             BorderSide(color: Color(0xFF212222))),
                        //     focusedBorder: const OutlineInputBorder(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(16)),
                        //         borderSide:
                        //             BorderSide(color: Color(0xFF424243))),
                        //     border: const OutlineInputBorder(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(16)),
                        //         borderSide:
                        //             BorderSide(color: Color(0xFF212222))),
                        //   ),
                        // )
