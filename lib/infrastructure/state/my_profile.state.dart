import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/profile.dart';

part 'my_profile.state.g.dart';

@Riverpod(keepAlive: true)
class MyProfileState extends _$MyProfileState {
  @override
  Profile? build() {
    return null;
  }

  void setProfile(Profile profile) {
    state = profile;
  }
}