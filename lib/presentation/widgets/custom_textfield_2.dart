import 'package:flutter/material.dart';

class CustomTextField2 extends StatelessWidget {
  const CustomTextField2({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
        border: InputBorder.none,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required.';
        }
        return null;
      },
    );
  }
}
