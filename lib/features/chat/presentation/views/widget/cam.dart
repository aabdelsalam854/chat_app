import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dd/features/chat/presentation/views/widget/show_send.dart';



import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/cam.dart';


class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key, required this.cameras, required this.email});
  final List<CameraDescription> cameras;

  final String email;
  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late CameraController camController;
  late Future<void> cameraValue;
  bool isFlashOn = false;
  bool isRealCam = true;
  bool _isRecording = false;
  void startCam(int camera) {
    camController =
        CameraController(widget.cameras[camera], ResolutionPreset.high);
    cameraValue = camController.initialize();
  }

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
    });
    camController.setFlashMode(isFlashOn ? FlashMode.torch : FlashMode.off);
  }

  @override
  void initState() {
    super.initState();
    startCam(0);
  }

  @override
  void dispose() {
    camController.dispose();
    super.dispose();
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await camController.stopVideoRecording();
      setState(() => _isRecording = false);

      File files = File(file.path);

      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => ShowSend(videoUrl: files,
            email: widget.email),
      );
      if (mounted) {
        Navigator.push(context, route);
      }
    } else {
      await camController.prepareForVideoRecording();
      await camController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FutureBuilder(
                    future: cameraValue,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SizedBox(
                          width: size.width,
                          height: size.height,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              height: 100,
                              child: CameraPreview(camController),
                            ),
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, right: 5),
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                toggleFlash();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(50, 0, 0, 0),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: isFlashOn
                                      ? const Icon(
                                          Icons.flash_on,
                                          color: Colors.white,
                                          size: 30,
                                        )
                                      : const Icon(
                                          Icons.flash_off,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                ),
                              )),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isRealCam = !isRealCam;
                                });
                                startCam(isRealCam ? 0 : 1);
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(50, 0, 0, 0),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: isFlashOn
                                      ? const Icon(
                                          Icons.cameraswitch_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        )
                                      : const Icon(
                                          Icons.cameraswitch_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                 heroTag: 'btn1',
                  onPressed: () {
                    SelectMediaFromStorage.selectMedia().then((mediaSelect) {
                      if (mediaSelect != null) {
                        List<File> imageFile = mediaSelect
                            .map((media) => File(media.path!))
                            .toList();
                        GoRouter.of(context).push(AppRouts.kMediaSelection,
                            extra: ({
                              'imageFile': imageFile,
                              'email': "email"
                            }));
                      }
                    });
                  },
                  backgroundColor: const Color.fromRGBO(225, 225, 225, .7),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.image,
                    size: 40,
                  ),
                ),
                FloatingActionButton(
                  heroTag: 'btn2',
                  onPressed: () {
                    camController.takePicture().then((value) {
                      File file = File(value.path);
                      GoRouter.of(context).push(AppRouts.kShowImageandSend,
                          extra: ({'imageFile': file, 'email': widget.email}));
                    });
                  },
                  backgroundColor: const Color.fromRGBO(225, 225, 225, .7),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 40,
                  ),
                ),
                FloatingActionButton(
                  heroTag:'btn3' ,
                  backgroundColor: Colors.red,
                  child: Icon(_isRecording ? Icons.stop : Icons.circle),
                  onPressed: () => _recordVideo(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
