import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class CustomTxtFormField extends StatelessWidget {
  const CustomTxtFormField({
    super.key,
    required this.hintText,
    this.validator,
    this.controller,
    this.onChanged,
  });

  final String hintText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.none,
      controller: controller,
      validator: validator,
      style: const TextStyle(fontSize: 15),
      onChanged: onChanged,
      decoration: InputDecoration(
        errorMaxLines: 2,
        errorStyle: const TextStyle(),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: const SizedBox(width: 15),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 16,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontVariations: fontWeightRegular,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
