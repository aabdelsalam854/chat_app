// class Recording {
//   static AudioRecorder record = AudioRecorder();

//   static Future<void> startRecord() async {
//     final location = await getApplicationDocumentsDirectory();
//     final name = const Uuid().v1(); //  عشان احفظ المكان بالظبط uid دا بيديني

//     if (await record.hasPermission()) // تم منح الاذن للوصول الي الميكرفون
//     {
//       await record.start(const RecordConfig(),
//           path:
//               '${location.path}$name.'); //  الباص ال هيتم حفظ في  الريكورد
//     }
//     debugPrint('start record');
//   }

//   static Future<void> stopRecord(String path) async {
//     final finalPath = await record.stop();// اغلاق الريكورد
//     debugPrint(finalPath);
//    debugPrint('stop Record');
//   }
// }
//  AudioRecorder record = AudioRecorder();

//   startRecord() async {
//     final location = await getApplicationDocumentsDirectory();
//     final name = const Uuid().v1();

//     if (await record.hasPermission()) {
//       await record.start(const RecordConfig(),
//           path: '${location.path}/$name.m4a');
//     }
//     debugPrint('start record');
//   }

//   stopRecord() async {
//     final finalPath = await record.stop();
//     setState(() {
//       path = finalPath!;
//     });
//     debugPrint(finalPath);
//     debugPrint('stop Record');
//   }