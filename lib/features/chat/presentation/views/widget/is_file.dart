import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

import '../../../../../core/fire_cloud/dowinlod_file.dart';
import '../../../data/model/messages_model.dart';



class IsFile extends StatefulWidget {
  const IsFile({
    super.key,
    required this.message,
    required this.messageModel,
  });

  final String message;
  final MessageModel messageModel;

  @override
  IsFileState createState() => IsFileState();
}

class IsFileState extends State<IsFile> {
  bool fileOpened = false;
  String? path;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!fileOpened) {
          try {
            path = await DownloadFile.downloadAndOpenFile(
                fileUrl: widget.message,
                fileName: widget.messageModel.metadata!.fileType ?? '');
            
            setState(() {
              fileOpened = true;
            });
          } catch (e) {
            debugPrint(e.toString());
          }
        }
        OpenFile.open(path);
      },
      
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1 / 2,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.1),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.messageModel.metadata!.fileName ?? ''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${widget.messageModel.metadata!.fileType ?? ''}.'),
                    Text(widget.messageModel.metadata!.fileSize.toString()),
                    SizedBox(
                      height: 30,
                      width: 40,
                      child: Image.asset(
                        'assets/images/${widget.messageModel.metadata!.fileType ?? ''}.png',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
