import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile.dart';

part 'sign_in_tokens.freezed.dart';
part 'sign_in_tokens.g.dart';

@freezed
class SignInTokens with _$SignInTokens {
  factory SignInTokens({
    String? accessToken,
    String? refreshToken,
    Profile? profile,
  }) = _SignInTokens;

  factory SignInTokens.fromJson(Map<String, dynamic> json) =>
      _$SignInTokensFromJson(json);
}