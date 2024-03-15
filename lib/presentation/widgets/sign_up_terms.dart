import 'package:flutter/material.dart';

import '../../core/ui/color.ui.dart';
import '../../core/ui/text.ui.dart';

class SignUpTerms extends StatelessWidget {
  const SignUpTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      style: textBody.copyWith(color: colorGreyText),
      const TextSpan(
        children: [
          TextSpan(
            text: "By signing up, you agree to our ",
          ),
          TextSpan(
            text: "Terms of Service",
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: colorGreen,
              color: colorGreen,
            ),
          ),
          TextSpan(
            text: " and acknowledge that our ",
          ),
          TextSpan(
            text: "Privacy Policy",
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: colorGreen,
              color: colorGreen,
            ),
          ),
          TextSpan(
            text: " applies to you.",
          ),
        ],
      ),
    );
  }
}
