import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.icon,
    this.hintText,
    this.onFieldSubmitted,
    this.prefixIcon,
     this.onChanged,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? icon;
  final String? hintText;
  final Widget? prefixIcon;
  final Function(String)? onFieldSubmitted;
    final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:onChanged ,
      controller: controller,
      validator: (data) {
        if (data!.isEmpty) {
          return "field is required";
        } else if (data.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        return null;
      },
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: icon,
        suffixIconColor: const Color(0xFF424243),
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF424243)),
        enabledBorder: const OutlineInputBorder(

            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
            
            color: Color(0xFF212222))),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFF424243))),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFF212222))),
      ),
    );
  }
}
