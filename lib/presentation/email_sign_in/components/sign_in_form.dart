import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/get_it.dart';
import '../../../core/extensions/context.extension.dart';
import '../../../domain/repository/auth.repository.dart';
import '../../../domain/requests/sign.request.dart';
import '../../../infrastructure/routing/app_pages.dart';
import '../../../infrastructure/state/is_focus_sign_form.state.dart';
import '../../widgets/green_button.dart';
import '../../widgets/underline_text_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    emailFocusNode.addListener(
      () => focusNodeListener(emailFocusNode.hasFocus),
    );
    passwordFocusNode.addListener(
      () => focusNodeListener(passwordFocusNode.hasFocus),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UnderlineTextField(
          controller: emailController,
          focusNode: emailFocusNode,
          hint: "Email",
        ),
        const SizedBox(height: 12),
        UnderlineTextField(
          controller: passwordController,
          focusNode: passwordFocusNode,
          hint: "Password",
          obscureText: true,
        ),
        const SizedBox(height: 40),
        GreenButton(
          title: "Sign in",
          onTap: () async {
            try {
              var formValidation = onValidateEmailPassword(
                email: emailController.text,
                password: passwordController.text,
              );
              if (formValidation != null) {
                return EasyLoading.showError(formValidation);
              }
              var authRepository = getIt.get<AuthRepository>();
              var signRequest = SignRequest(
                email: emailController.text,
                password: passwordController.text,
              );
              EasyLoading.show();
              var signInRes = await authRepository.signIn(signRequest);
              if (signInRes.success == true) {
                if (signInRes.data?.profile == null) {
                  AppPages.navKey.currentContext?.go(Routes.CREATE_PROFILE);
                }
              } else {
                EasyLoading.showError(signInRes.error ?? "Sign up failed");
              }
            } catch (e) {
              EasyLoading.showError("Sign up failed. $e");
            } finally {
              EasyLoading.dismiss();
            }
          },
        )
      ],
    );
  }

  void focusNodeListener(bool hasFocus) {
    context.provider
        .read(isFocusSignFormStateProvider.notifier)
        .setFocus(hasFocus);
  }

  String? onValidateEmailPassword({
    required String email,
    required String password,
  }) {
    final emailValidation =
        ValidationBuilder().required().email().build()(email);
    if (emailValidation != null) {
      return "Your email is not valid";
    }
    final passwordValidation = ValidationBuilder().required().build()(password);
    if (passwordValidation != null) {
      return "Your password is not valid";
    }
    return null;
  }
}
