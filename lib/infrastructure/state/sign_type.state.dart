import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_type.state.g.dart';

@riverpod
class SignTypeState extends _$SignTypeState {
  @override
  SignTypeEnum build() {
    return SignTypeEnum.signUp;
  }

  void toggle() {
    state = state == SignTypeEnum.signUp
        ? SignTypeEnum.signIn
        : SignTypeEnum.signUp;
  }
}

enum SignTypeEnum {
  signIn,
  signUp,
}
