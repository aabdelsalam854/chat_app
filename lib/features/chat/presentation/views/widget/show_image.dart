import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({
    super.key,
    required this.message,
  });
  final String? message;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Image.network(
          message!,
),
      ),
    );
  }
}
