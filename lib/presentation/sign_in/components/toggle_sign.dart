import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/context.extension.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../infrastructure/state/sign_type.state.dart';

class ToggleSign extends StatelessWidget {
  const ToggleSign({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: () {
          context.provider
              .read(signTypeStateProvider.notifier)
              .toggle();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: textLargeBody,
              ),
              Consumer(
                builder: (context, ref, child) {
                  return Text(
                    ref.watch(signTypeStateProvider) ==
                        SignTypeEnum.signUp
                        ? "Sign in"
                        : "Sign up",
                    style: textLargeBody.copyWith(
                      color: colorGreen,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
