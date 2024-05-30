import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/profile.dart';

part 'current_other_profile.state.g.dart';

@Riverpod(keepAlive: true)
class CurrentOtherProfileState extends _$CurrentOtherProfileState {
  @override
  Profile? build() {
    return null;
  }

  void setProfile(Profile? value) {
    state = value;
  }
}