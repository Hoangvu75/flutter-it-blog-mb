import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_validator/form_validator.dart';

import '../../../core/config/get_it.dart';
import '../../../core/extensions/context.extension.dart';
import '../../../domain/repository/auth.repository.dart';
import '../../../domain/requests/sign.request.dart';
import '../../../infrastructure/state/is_focus_sign_form.state.dart';
import '../../widgets/app_green_button.dart';
import '../../widgets/sign_text_field.dart';

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
        SignTextField(
          controller: emailController,
          focusNode: emailFocusNode,
          hint: "Email",
        ),
        const SizedBox(height: 12),
        SignTextField(
          controller: passwordController,
          focusNode: passwordFocusNode,
          hint: "Password",
          obscureText: true,
        ),
        const SizedBox(height: 40),
        AppGreenButton(
          title: "Sign in",
          onTap: () async {
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
            var signUpRes = await authRepository.signIn(signRequest);
            EasyLoading.dismiss();
            // if (signUpRes.success == true) {
            //   EasyLoading.showSuccess(
            //     "Sign up successfully\nYou can sign in now",
            //     duration: const Duration(seconds: 3),
            //   ).then((value) {
            //     context.pop();
            //   });
            // } else {
            //   await EasyLoading.showError(
            //     signUpRes.error ?? "Sign up failed by undefined error",
            //     duration: const Duration(seconds: 3),
            //   );
            // }
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
