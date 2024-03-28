import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../infrastructure/routing/app_pages.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Material(
        color: colorGreen,
        child: InkWell(
          onTap: () => context.go(Routes.MAIN),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              "Continue",
              textAlign: TextAlign.center,
              style: textLargeBody.copyWith(
                color: colorSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
