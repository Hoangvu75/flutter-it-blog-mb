import 'package:flutter/material.dart';

import '../../core/ui/color.ui.dart';
import '../../core/ui/screen.ui.dart';
import '../../core/ui/text.ui.dart';
import '../widgets/sign_up_terms.dart';
import '../widgets/app_logo.dart';
import 'components/sign_up_form.dart';

class EmailSignUpPage extends StatelessWidget {
  const EmailSignUpPage({super.key});

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
                  "CREATE YOUR ACCOUNT",
                  style: textLargeBody.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "What's your\nemail?",
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
                const SignUpForm(),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: SignUpTerms(),
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
