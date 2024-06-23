import 'package:flutter/material.dart';

class CusttomTextBottom extends StatelessWidget {
  const CusttomTextBottom({super.key,  required this.onPressed, required this.text});
 final Function() onPressed;
 final String text;

  @override
  Widget build(BuildContext context) {
    return  TextButton(
      
onPressed: onPressed,
child: Text(text,
   style: const TextStyle(color: Color(0xFF4E4E4E))
    ));
  }
}