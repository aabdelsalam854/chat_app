import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class UploadFileInFirebase {
  static Future<String> uploadFile(File file) async {
    try {
      final upload =
          await FirebaseStorage.instance.ref().child(file.path).putFile(file);
      final url = await upload.ref.getDownloadURL();
      return url;
    } on Exception catch (e) {
      e.toString();
      return '';
    }
  }
}




class UploadFileInFirebaseMuiflty {
  static Future<List<String>> uploadFiles(List<File> files) async {
    List<String> imagesUrls = [];

    for (int i = 0; i < files.length; i++) {
      File image = files[i];
      final uploadTask = FirebaseStorage.instance.ref().child(image.path).putFile(image);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      imagesUrls.add(downloadUrl);
    }

    log(imagesUrls.toString());
    return imagesUrls;
  }
}