import 'package:flutter/material.dart';

import '../../../../../core/constant/constant.dart';

class CustomBottom extends StatelessWidget {
  const CustomBottom({super.key, required this.text, required this.onPressed});
  final String text;

  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 50,
      child: MaterialButton(
        onPressed: onPressed,
        textColor: const Color(0xFF7C7D7D),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: kCustomBottomColors,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
