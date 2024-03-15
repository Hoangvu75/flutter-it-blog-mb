import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/assets.dart';
import '../../../infrastructure/routing/app_pages.dart';
import '../sign_in.page.dart';
import 'sign_button.dart';

class SignInButtons extends StatelessWidget {
  const SignInButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SignButton(
          title: "Sign in with Google",
          iconPath: Assets.svgGoogle,
          onTap: SignInPage.signInWithGoogle,
        ),
        const SizedBox(height: 16),
        SignButton(
          title: "Sign in with Facebook",
          iconPath: Assets.svgFacebook,
          onTap: () {},
        ),
        const SizedBox(height: 16),
        SignButton(
          title: "Sign in with Email",
          iconPath: Assets.svgEmail,
          onTap: () {
            context.push(Routes.EMAIL_SIGN_IN);
          },
        ),
      ],
    );
  }
}
