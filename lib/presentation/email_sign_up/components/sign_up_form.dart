import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/get_it.dart';
import '../../../core/extensions/context.extension.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../domain/repository/auth.repository.dart';
import '../../../domain/requests/sign.request.dart';
import '../../../infrastructure/routing/app_pages.dart';
import '../../../infrastructure/state/is_focus_sign_form.state.dart';
import '../../widgets/green_button.dart';
import '../../widgets/underline_text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    emailFocusNode.addListener(
      () => focusNodeListener(emailFocusNode.hasFocus),
    );
    passwordFocusNode.addListener(
      () => focusNodeListener(passwordFocusNode.hasFocus),
    );
    confirmPasswordFocusNode.addListener(
      () => focusNodeListener(confirmPasswordFocusNode.hasFocus),
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
        const SizedBox(height: 12),
        UnderlineTextField(
          controller: confirmPasswordController,
          focusNode: confirmPasswordFocusNode,
          hint: "Confirm password",
          obscureText: true,
        ),
        const SizedBox(height: 40),
        GreenButton(
          title: "Sign up",
          onTap: () async {
            try {
              var formValidation = onValidateEmailPassword(
                email: emailController.text,
                password: passwordController.text,
                confirmPassword: confirmPasswordController.text,
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
              var signUpRes = await authRepository.signUp(signRequest);
              EasyLoading.dismiss();
              if (signUpRes.isSuccess()) {
                EasyLoading.showSuccess(
                  "Sign up successfully\nYou can sign in now",
                );
                navContext?.pop();
              } else {
                await EasyLoading.showError(
                  signUpRes.error ?? "Sign up failed by undefined error",
                );
              }
            } catch (e) {
              EasyLoading.dismiss();
              EasyLoading.showError("Sign up failed $e");
            }
          },
        ),
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
    required String confirmPassword,
  }) {
    final emailValidation =
        ValidationBuilder().required().email().build()(email);
    if (emailValidation != null) {
      return "Your email is not valid";
    }
    final passwordValidation =
        ValidationBuilder().required().minLength(8).build()(password);
    if (passwordValidation != null) {
      return "Password must be at least 8 characters long";
    }
    if (password != confirmPassword) {
      return "Passwords do not match";
    }
    return null;
  }
}
