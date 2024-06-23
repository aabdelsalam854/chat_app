
import 'package:dd/features/chat/presentation/views/widget/show_image_and_send.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/cam.dart';

class SelectImage extends StatelessWidget {
  const SelectImage({
    super.key,
    required this.email,
    required this.imageSource,
    required this.name,
    required this.icon,
  });
  final String email;
  final ImageSource imageSource;
  final String name;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          ImagePickerHelper.imageSelector(image: imageSource)
              .then((imageFromGallery) {
            if (imageFromGallery != null) {
              showBottomSheet(
                context: context,
                builder: (context) {
                  return ShowImageAndSend(
                      imageFromGallery: imageFromGallery, email: email);
                },
              );
            }
          });
        },
        title: Text(
          name,
        ),
        leading: icon,
      ),
    );
  }
}
