import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dd/features/chat/presentation/views/widget/cam.dart';
import 'package:dd/features/chat/presentation/views/widget/divider_widget.dart';
import 'package:dd/features/chat/presentation/views/widget/selcet_file.dart';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/cam.dart';


class MediaSelection extends StatelessWidget {
  const MediaSelection({
    super.key,
    required this.email,
  });

  final String email;

  @override
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        color: Colors.black26,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
              child: DividerWidget(),
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  await availableCameras().then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CameraWidget(
                            email: email,
                            cameras: value)),
                    );
                  });
                },
                title: const Text('camera'),
                leading: const Icon(Icons.camera),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  SelectMediaFromStorage.selectMedia().then((mediaSelect) {
                    if (mediaSelect != null) {
                      List<File> imageFile = mediaSelect
                          .map((media) => File(media.path!))
                          .toList();
                      GoRouter.of(context).push(AppRouts.kMediaSelection,
                          extra: ({'imageFile': imageFile, 'email': email}));
                    }
                  });
                },
                title: const Text('Select Media'),
                leading: const Icon(Icons.camera),
              ),
            ),
       
            SelectFile(email: email),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
