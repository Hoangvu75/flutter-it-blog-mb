import 'package:flutter/material.dart';

import '../../core/ui/color.ui.dart';
import '../../core/ui/screen.ui.dart';
import '../../core/ui/text.ui.dart';
import '../widgets/app_logo.dart';
import 'components/profile_form.dart';

class CreateProfilePage extends StatelessWidget {
  const CreateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          surfaceTintColor: colorTransparent,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight(context) - statusBarHeight(context),
            width: screenWidth(context),
            child: Column(
              children: [
                const AppLogo(),
                const SizedBox(height: 32),
                Text(
                  "About\nyourself",
                  style: textLargeHeader.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                const Text(
                  "Your information",
                  style: textLargeBody,
                ),
                const SizedBox(height: 16),
                const ProfileForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
