import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/screen.ui.dart';
import '../../../generated/assets.dart';
import '../../../infrastructure/state/is_focus_sign_form.state.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var isFormFocused = ref.watch(isFocusSignFormStateProvider);
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              key: ValueKey(isFormFocused),
              child: isFormFocused
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        const SizedBox(height: 32),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth(context) * 0.3,
                          ),
                          child: Image.asset(Assets.imagesAppLogo),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
