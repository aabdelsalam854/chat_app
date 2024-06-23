import 'package:file_picker/file_picker.dart';

class SelectFileFromStorage {
  static Future<PlatformFile?> selectFiles() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
       allowMultiple: true,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
     if (res != null) {
      return res.files.first;
    }
     return null;
  }
}

