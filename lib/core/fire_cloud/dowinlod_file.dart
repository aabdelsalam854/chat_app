import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class DownloadFile {
  static Future<String> downloadAndOpenFile(
      {required String fileUrl, required String fileName}) async {
    Dio dio = Dio();

    try {
      var dir = await getExternalStorageDirectory();
      String savePath = '${dir!.path}/$fileName';

      await dio.download(fileUrl, savePath,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          debugPrint("${(received / total * 100).toStringAsFixed(0)}%");
        }
      });
      return savePath;
    } catch (e) {
      debugPrint("Error downloading file: $e");
      rethrow;
    }
  }
}