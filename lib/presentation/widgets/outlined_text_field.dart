import 'package:flutter/material.dart';

import '../../core/ui/color.ui.dart';
import '../../core/ui/text.ui.dart';

class OutlinedTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final bool obscureText;

  const OutlinedTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hint,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      style: textLargeBody,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12
        ),
        isDense: true,
        hintText: hint,
        hintStyle: textLargeBody.copyWith(color: colorGreyText),
        focusColor: colorPrimary,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: colorGreyText,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: colorPrimary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      obscureText: obscureText,
      cursorColor: colorPrimary,
      onFieldSubmitted: (_) => focusNode.unfocus(),
    );
  }
}
