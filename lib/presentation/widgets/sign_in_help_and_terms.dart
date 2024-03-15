import 'package:flutter/material.dart';

import '../../core/ui/color.ui.dart';
import '../../core/ui/text.ui.dart';

class SignInHelpAndTerms extends StatelessWidget {
  const SignInHelpAndTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          textAlign: TextAlign.center,
          style: textBody.copyWith(color: colorGreyText),
          const TextSpan(
            children: [
              TextSpan(
                text: "Forgot email or trouble signing in? ",
              ),
              TextSpan(
                text: "Get help.",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Text.rich(
          textAlign: TextAlign.center,
          style: textBody.copyWith(color: colorGreyText),
          const TextSpan(
            children: [
              TextSpan(
                text: "By signing in, you agree to our ",
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
        ),
      ],
    );
  }
}
