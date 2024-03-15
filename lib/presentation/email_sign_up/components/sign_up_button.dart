import 'package:flutter/material.dart';

import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';

class SignUpButton extends StatelessWidget {
  final Function() onTap;

  const SignUpButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Material(
          color: colorGreen,
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              child: Center(
                child: Text(
                  "Sign up",
                  style: textLargeBody.copyWith(
                    color: colorSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
