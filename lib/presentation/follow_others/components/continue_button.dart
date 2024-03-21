import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/get_it.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../domain/repository/topic.repository.dart';
import '../../../infrastructure/routing/app_pages.dart';
import '../../../infrastructure/state/selected_topics.state.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Material(
        color: colorGreen,
        child: InkWell(
          onTap: () {},
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
