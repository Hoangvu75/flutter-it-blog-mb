import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/assets.dart';
import '../../../infrastructure/routing/app_pages.dart';
import '../sign_in.page.dart';
import 'sign_button.dart';

class SignUpButtons extends StatelessWidget {
  const SignUpButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SignButton(
          title: "Sign up with Google",
          iconPath: Assets.svgGoogle,
          onTap: SignInPage.signInWithGoogle,
        ),
        const SizedBox(height: 16),
        SignButton(
          title: "Sign up with Facebook",
          iconPath: Assets.svgFacebook,
          onTap: () {},
        ),
        const SizedBox(height: 16),
        SignButton(
          title: "Sign up with Email",
          iconPath: Assets.svgEmail,
          onTap: () => context.push(Routes.EMAIL_SIGN_UP),
        ),
      ],
    );
  }
}
