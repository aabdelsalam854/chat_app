
import 'package:dd/features/chat/presentation/views/widget/file_tipe.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class BuildFileWidget extends StatelessWidget {
  const BuildFileWidget({
    super.key,
    required this.file,
  });

  final PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    if (file == null) return const SizedBox.shrink();
    String extension = file!.extension!.toLowerCase();
    String image = 'assets/images/$extension.png';
    switch (extension) {
      case 'pdf':
        return PDFView(
          filePath: file!.path,
          autoSpacing: false,
          enableSwipe: false,
          pageFling: false,
        );
      case 'jpg':
      case 'png':
      case 'mp4':
      case 'doc':
      case 'docx':
      case 'mp3':
        return FileTipe(pickedFile: file, image: image);

      default:
        return FileTipe(pickedFile: file, image: 'assets/images/doc.png');
    }
  }
}
