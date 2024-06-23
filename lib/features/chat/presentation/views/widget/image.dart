import 'dart:io';

import 'package:flutter/material.dart';

class FileChatBubbleimage extends StatelessWidget {
  const FileChatBubbleimage({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(
            File(url),
            width: 200, 
            height: 200, 
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}