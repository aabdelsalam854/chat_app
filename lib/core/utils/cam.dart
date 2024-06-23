import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<File?> imageSelector({ImageSource? image}) async {
    XFile? images = await ImagePicker().pickImage(source: image!);
    // XFile? images = await ImagePicker().pickVideo(
    //   source: image!,
    // );
    if (images != null) {
      return File(images.path);
    }

    return null;
  }
}

class ImageHelper {
  List<File> selectedImages = [];

  Future<void> addImages() async {
    final picker = ImagePicker();
    final List<XFile> images = await picker.pickMultipleMedia(
      imageQuality: 50,
      maxWidth: 800,
      maxHeight: 600,
    );

    for (XFile image in images) {
      selectedImages.add(File(image.path));
    }
  }
}

class SelectMediaFromStorage {
 
  static Future<List<PlatformFile>?> selectMedia() async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
    );
    if (res != null) {
      log(res.files.toString());
      return res.files;
    }
    return null;
  }
}



  // Future<void> getMedia() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.getMedia(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       if (pickedFile.path.endsWith('.mp4')) {
  //         _videoFile = File(pickedFile.path);
  //         _videoPlayerController = VideoPlayerController.file(_videoFile)..initialize().then((_) {
  //           setState(() {});
  //         });
  //       } else {
  //         _imageFile = File(pickedFile.path);
  //         _videoFile = null;
  //         _videoPlayerController?.dispose();
  //       }
  //     } else {
  //       print('No media selected.');
  //     }
  //   });
  // }
