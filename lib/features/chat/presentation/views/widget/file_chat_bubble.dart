import 'package:flutter/material.dart';
import '../../../../../core/constant/constant.dart';

class FileChatBubble extends StatelessWidget {
   const FileChatBubble({
    super.key, 
    required this.url,
   
  });
final String url;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding:
            const EdgeInsets.only(bottom: 16, top: 16, left: 16, right: 16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
              bottomLeft: Radius.circular(0),
            ),
            color: kCustomBottomColors),
        child:  Text(
         url.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

 