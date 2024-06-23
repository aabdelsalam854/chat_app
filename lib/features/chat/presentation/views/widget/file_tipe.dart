import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/get_file_size.dart';

class FileTipe extends StatelessWidget {
  const FileTipe({
    super.key,
    required this.pickedFile,
    required this.image,
  });

  final PlatformFile? pickedFile;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60, width: 60, child: Image.asset(image)),
            Text(
              pickedFile!.name,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              pickedFile!.extension!,
              style: const TextStyle(color: Colors.grey),
            ),
            Text('${(GetFileSize.getFileSize(pickedFile!.size.round()))} ',
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
