import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class CustomTxtFormField extends StatelessWidget {
  const CustomTxtFormField({
    super.key,
    required this.hintText,
    this.labelText,
    this.readOnly,
    this.validator,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.suffix,
  });

  final String hintText;
  final String? labelText;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return TextFormField(
      obscureText: obscureText,
      readOnly: readOnly ?? false,
      textCapitalization: TextCapitalization.none,
      controller: controller,
      validator: validator,
      style: const TextStyle(fontSize: 15),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        errorMaxLines: 2,
        errorStyle: const TextStyle(),
        suffixIcon: suffix,
        suffixIconColor: Theme.of(context).colorScheme.primary,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: const SizedBox(width: 15),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 16,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: theme.colorScheme.secondary,
          fontSize: 14,
          fontVariations: fontWeightRegular,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: theme.colorScheme.outline,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: theme.colorScheme.onPrimary,
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
