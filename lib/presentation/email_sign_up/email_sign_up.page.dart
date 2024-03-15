import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/color.ui.dart';
import '../../core/ui/screen.ui.dart';
import '../../core/ui/text.ui.dart';
import '../../generated/assets.dart';
import '../../infrastructure/state/is_focus_sign_form.state.dart';
import '../widgets/sign_up_terms.dart';
import 'components/app_logo.dart';
import 'components/sign_up_form.dart';

class EmailSignUpPage extends StatefulWidget {
  const EmailSignUpPage({super.key});

  @override
  State<EmailSignUpPage> createState() => _EmailSignUpPageState();
}

class _EmailSignUpPageState extends State<EmailSignUpPage> {
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
