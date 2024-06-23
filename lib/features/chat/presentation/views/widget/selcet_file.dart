import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/select_file_from_storage.dart';

class SelectFile extends StatelessWidget {
  const SelectFile({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          await SelectFileFromStorage.selectFiles().then((pickedFile) {
            if (pickedFile != null) {
              GoRouter.of(context).push(
                AppRouts.kShowFileBeforeSend,
                extra: ({'file': pickedFile, 'email': email}),
              );
            }
            Navigator.pop(context);
          });
        },
        title: const Text(
          'file',
        ),
        leading: const Icon(Icons.file_copy),
      ),
    );
  }
}

