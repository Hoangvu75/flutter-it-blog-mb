import 'package:flutter/material.dart';

import '../../core/ui/color.ui.dart';
import '../../core/ui/text.ui.dart';

class UnderlineTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final bool obscureText;

  const UnderlineTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hint,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        style: textLargeBody,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          isDense: true,
          hintText: hint,
          hintStyle: textLargeBody.copyWith(color: colorGreyText),
          focusColor: colorPrimary,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: colorPrimary),
          ),
        ),
        obscureText: obscureText,
        textAlign: TextAlign.center,
        cursorColor: colorPrimary,
      ),
    );
  }
}
