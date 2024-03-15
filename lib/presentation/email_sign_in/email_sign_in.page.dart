import 'package:flutter/material.dart';

import '../../core/ui/color.ui.dart';
import '../../core/ui/screen.ui.dart';
import '../../core/ui/text.ui.dart';
import '../widgets/app_logo.dart';
import '../widgets/sign_in_help_and_terms.dart';
import 'components/sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({super.key});

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
                  "Sign in with\nyour email",
                  style: textLargeHeader.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                const Text(
                  "Your email & password",
                  style: textLargeBody,
                ),
                const SizedBox(height: 16),
                const SignInForm(),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: SignInHelpAndTerms(),
                ),
                const SizedBox(height: 32)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
