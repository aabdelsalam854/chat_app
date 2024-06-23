import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/fire_cloud/fire_cloud.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/upload_file_in_firebase.dart';
import '../../../../login/presentation/views/widget/custom_text_form_field.dart';
import '../../../data/model/messages_model.dart';
import '../../../data/model/metadata_model.dart';

class ShowMultyImage extends StatefulWidget {
  const ShowMultyImage({
    super.key,
    required this.file,
    required this.email,
  });

  final List<File> file;
  final String email;

  @override
  State<ShowMultyImage> createState() => _ShowMultyImageState();
}

class _ShowMultyImageState extends State<ShowMultyImage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        height: MediaQuery.sizeOf(context).height,
                        viewportFraction: 1,
                        scrollPhysics: widget.file.length == 1
                            ? const NeverScrollableScrollPhysics()
                            : null),
                    items: widget.file.map((files) {
                      switch (files.path.split('.').last) {
                        case 'jpg':
                        case 'png':
                        case 'jpeg':
                          return Image.file(files);

                        default:
                       return  Image.file(files);
                      }
                    }).toList(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: widget.file.length > 1
                        ? Padding(
                            padding: const EdgeInsets.all(20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      Row(
                                        children: List.generate(
                                            widget.file.length, (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              widget.file.removeAt(index);
                                              setState(() {});
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: FileImage(
                                                          widget.file[index]),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                                const Positioned.fill(
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Icon(
                                                          Icons
                                                              .delete_forever_outlined,
                                                          size: 50,
                                                          color: Colors.grey,
                                                        ))),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    GoRouter.of(context).pop(AppRouts.kChatView);
                    for (var index = 0; index < widget.file.length; index++) {
                      final imageUrl = await UploadFileInFirebase.uploadFile(
                          widget.file[index]);

                      String fileType;
                      switch (widget.file[index].path.split('.').last) {
                        case 'jpg':
                        case 'jpeg':
                        case 'png':
                          fileType = 'MessageType.image'; // إذا كان الملف صورة
                          break;
                        case 'mp4':
                          fileType = 'MessageType.video'; // إذا كان الملف فيديو
                          break;
                        default:
                          fileType = 'MessageType.image';
                          break;
                      }
                      await FireCloud.sendMessage(MessageModel(
                        message: imageUrl,
                        id: widget.email,
                        type: fileType,
                        metadata: MetadataModel(
                          fileName: widget.file[index].path.split('/').last,
                          fileSize: null,
                          width: null,
                          height: null,
                          fileType: widget.file[index].path.split('.').last,
                          details: controller.text,
                        ),
                        time: DateTime.now(),
                      ));
                    }
                  },
                  child: const Text('Send All'),
                ),
                Expanded(
                  child: CustomTextFormField(
                    controller: controller,
                    hintText: 'Type a description',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
