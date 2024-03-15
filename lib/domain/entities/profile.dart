import 'package:freezed_annotation/freezed_annotation.dart';

import 'account.dart';
import 'topic.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  factory Profile({
    String? id,
    Account? account,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? phone,
    String? address,
    String? gender,
    String? avatarUrl,
    List<Topic>? favoriteTopics,
    String? createdAt,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}