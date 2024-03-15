import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_focus_sign_form.state.g.dart';

@riverpod
class IsFocusSignFormState extends _$IsFocusSignFormState {
  @override
  bool build() {
    return false;
  }

  void setFocus(bool value) {
    state = value;
  }
}
