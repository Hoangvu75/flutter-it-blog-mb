import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/config/get_it.dart';
import '../../core/ui/color.ui.dart';
import '../../core/ui/screen.ui.dart';
import '../../core/ui/text.ui.dart';
import '../../core/util/constants.dart';
import '../../domain/repository/auth.repository.dart';
import '../../domain/requests/google_sign_in.request.dart';
import '../../generated/assets.dart';
import '../../infrastructure/routing/app_pages.dart';
import '../../infrastructure/services/storage.service.dart';
import '../../infrastructure/state/sign_type.state.dart';
import 'components/sign_in_buttons.dart';
import '../widgets/sign_in_help_and_terms.dart';
import 'components/sign_up_buttons.dart';
import '../widgets/sign_up_terms.dart';
import 'components/toggle_sign.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        surfaceTintColor: colorTransparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth(context) * 0.3,
              ),
              child: Image.asset(
                Assets.imagesAppLogo,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Human stories\nand ideas.",
              style: textVeryLargeHeader,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Text(
              "Discover perspectives that deepen understanding.",
              style: textSmallTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Consumer(
              builder: (context, ref, child) {
                switch (ref.watch(signTypeStateProvider)) {
                  case SignTypeEnum.signUp:
                    return const SignUpButtons();
                  case SignTypeEnum.signIn:
                    return const SignInButtons();
                }
              },
            ),
            const SizedBox(height: 24),
            const ToggleSign(),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Consumer(
                builder: (context, ref, child) {
                  switch (ref.watch(signTypeStateProvider)) {
                    case SignTypeEnum.signUp:
                      return const SignUpTerms();
                    case SignTypeEnum.signIn:
                      return const SignInHelpAndTerms();
                  }
                },
              ),
            ),
            const SizedBox(height: 32)
          ],
        ),
      ),
    );
  }

  static Future<void> signInWithGoogle() async {
    try {
      var googleSignIn = (Platform.isIOS)
          ? GoogleSignIn(clientId: Constants.GOOGLE_IOS_CLIENT_ID)
          : GoogleSignIn();
      var account = await googleSignIn.signIn();
      var authRepository = getIt.get<AuthRepository>();
      var email = account?.email;
      if (email == null) {
        throw Exception("Email is null");
      }
      EasyLoading.show();
      var signInRes = await authRepository.googleSignIn(
        GoogleSignInRequest(email: email),
      );
      EasyLoading.dismiss();
      if (signInRes.isSuccess()) {
        final storageService = getIt.get<StorageService>();
        storageService.saveToken(signInRes.data!.accessToken!);
        if (signInRes.data?.profile == null) {
          navContext?.go(Routes.CREATE_PROFILE);
          return;
        }
        navContext?.go(Routes.PICK_TOPICS);
      } else {
        EasyLoading.showError(signInRes.error ?? "Sign in failed");
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }
}
