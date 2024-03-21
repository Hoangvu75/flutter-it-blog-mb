// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  String? get id => throw _privateConstructorUsedError;
  Account? get account => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get dateOfBirth => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get job => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  List<Topic>? get favoriteTopics => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call(
      {String? id,
      Account? account,
      String? firstName,
      String? lastName,
      String? dateOfBirth,
      String? phone,
      String? job,
      String? company,
      String? address,
      String? gender,
      String? avatarUrl,
      List<Topic>? favoriteTopics,
      String? createdAt});

  $AccountCopyWith<$Res>? get account;
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? account = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? dateOfBirth = freezed,
    Object? phone = freezed,
    Object? job = freezed,
    Object? company = freezed,
    Object? address = freezed,
    Object? gender = freezed,
    Object? avatarUrl = freezed,
    Object? favoriteTopics = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Account?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      favoriteTopics: freezed == favoriteTopics
          ? _value.favoriteTopics
          : favoriteTopics // ignore: cast_nullable_to_non_nullable
              as List<Topic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AccountCopyWith<$Res>? get account {
    if (_value.account == null) {
      return null;
    }

    return $AccountCopyWith<$Res>(_value.account!, (value) {
      return _then(_value.copyWith(account: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
          _$ProfileImpl value, $Res Function(_$ProfileImpl) then) =
      __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      Account? account,
      String? firstName,
      String? lastName,
      String? dateOfBirth,
      String? phone,
      String? job,
      String? company,
      String? address,
      String? gender,
      String? avatarUrl,
      List<Topic>? favoriteTopics,
      String? createdAt});

  @override
  $AccountCopyWith<$Res>? get account;
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
      _$ProfileImpl _value, $Res Function(_$ProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? account = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? dateOfBirth = freezed,
    Object? phone = freezed,
    Object? job = freezed,
    Object? company = freezed,
    Object? address = freezed,
    Object? gender = freezed,
    Object? avatarUrl = freezed,
    Object? favoriteTopics = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ProfileImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Account?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      favoriteTopics: freezed == favoriteTopics
          ? _value._favoriteTopics
          : favoriteTopics // ignore: cast_nullable_to_non_nullable
              as List<Topic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileImpl implements _Profile {
  _$ProfileImpl(
      {this.id,
      this.account,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.phone,
      this.job,
      this.company,
      this.address,
      this.gender,
      this.avatarUrl,
      final List<Topic>? favoriteTopics,
      this.createdAt})
      : _favoriteTopics = favoriteTopics;

  factory _$ProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImplFromJson(json);

  @override
  final String? id;
  @override
  final Account? account;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? dateOfBirth;
  @override
  final String? phone;
  @override
  final String? job;
  @override
  final String? company;
  @override
  final String? address;
  @override
  final String? gender;
  @override
  final String? avatarUrl;
  final List<Topic>? _favoriteTopics;
  @override
  List<Topic>? get favoriteTopics {
    final value = _favoriteTopics;
    if (value == null) return null;
    if (_favoriteTopics is EqualUnmodifiableListView) return _favoriteTopics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? createdAt;

  @override
  String toString() {
    return 'Profile(id: $id, account: $account, firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth, phone: $phone, job: $job, company: $company, address: $address, gender: $gender, avatarUrl: $avatarUrl, favoriteTopics: $favoriteTopics, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.job, job) || other.job == job) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            const DeepCollectionEquality()
                .equals(other._favoriteTopics, _favoriteTopics) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      account,
      firstName,
      lastName,
      dateOfBirth,
      phone,
      job,
      company,
      address,
      gender,
      avatarUrl,
      const DeepCollectionEquality().hash(_favoriteTopics),
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImplToJson(
      this,
    );
  }
}

abstract class _Profile implements Profile {
  factory _Profile(
      {final String? id,
      final Account? account,
      final String? firstName,
      final String? lastName,
      final String? dateOfBirth,
      final String? phone,
      final String? job,
      final String? company,
      final String? address,
      final String? gender,
      final String? avatarUrl,
      final List<Topic>? favoriteTopics,
      final String? createdAt}) = _$ProfileImpl;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$ProfileImpl.fromJson;

  @override
  String? get id;
  @override
  Account? get account;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get dateOfBirth;
  @override
  String? get phone;
  @override
  String? get job;
  @override
  String? get company;
  @override
  String? get address;
  @override
  String? get gender;
  @override
  String? get avatarUrl;
  @override
  List<Topic>? get favoriteTopics;
  @override
  String? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MostFollowedProfile _$MostFollowedProfileFromJson(Map<String, dynamic> json) {
  return _MostFollowedProfile.fromJson(json);
}

/// @nodoc
mixin _$MostFollowedProfile {
  Profile? get profile => throw _privateConstructorUsedError;
  int? get followerCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MostFollowedProfileCopyWith<MostFollowedProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MostFollowedProfileCopyWith<$Res> {
  factory $MostFollowedProfileCopyWith(
          MostFollowedProfile value, $Res Function(MostFollowedProfile) then) =
      _$MostFollowedProfileCopyWithImpl<$Res, MostFollowedProfile>;
  @useResult
  $Res call({Profile? profile, int? followerCount});

  $ProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class _$MostFollowedProfileCopyWithImpl<$Res, $Val extends MostFollowedProfile>
    implements $MostFollowedProfileCopyWith<$Res> {
  _$MostFollowedProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = freezed,
    Object? followerCount = freezed,
  }) {
    return _then(_value.copyWith(
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile?,
      followerCount: freezed == followerCount
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res>? get profile {
    if (_value.profile == null) {
      return null;
    }

    return $ProfileCopyWith<$Res>(_value.profile!, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MostFollowedProfileImplCopyWith<$Res>
    implements $MostFollowedProfileCopyWith<$Res> {
  factory _$$MostFollowedProfileImplCopyWith(_$MostFollowedProfileImpl value,
          $Res Function(_$MostFollowedProfileImpl) then) =
      __$$MostFollowedProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Profile? profile, int? followerCount});

  @override
  $ProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class __$$MostFollowedProfileImplCopyWithImpl<$Res>
    extends _$MostFollowedProfileCopyWithImpl<$Res, _$MostFollowedProfileImpl>
    implements _$$MostFollowedProfileImplCopyWith<$Res> {
  __$$MostFollowedProfileImplCopyWithImpl(_$MostFollowedProfileImpl _value,
      $Res Function(_$MostFollowedProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = freezed,
    Object? followerCount = freezed,
  }) {
    return _then(_$MostFollowedProfileImpl(
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile?,
      followerCount: freezed == followerCount
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MostFollowedProfileImpl implements _MostFollowedProfile {
  _$MostFollowedProfileImpl({this.profile, this.followerCount});

  factory _$MostFollowedProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$MostFollowedProfileImplFromJson(json);

  @override
  final Profile? profile;
  @override
  final int? followerCount;

  @override
  String toString() {
    return 'MostFollowedProfile(profile: $profile, followerCount: $followerCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MostFollowedProfileImpl &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.followerCount, followerCount) ||
                other.followerCount == followerCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, profile, followerCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MostFollowedProfileImplCopyWith<_$MostFollowedProfileImpl> get copyWith =>
      __$$MostFollowedProfileImplCopyWithImpl<_$MostFollowedProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MostFollowedProfileImplToJson(
      this,
    );
  }
}

abstract class _MostFollowedProfile implements MostFollowedProfile {
  factory _MostFollowedProfile(
      {final Profile? profile,
      final int? followerCount}) = _$MostFollowedProfileImpl;

  factory _MostFollowedProfile.fromJson(Map<String, dynamic> json) =
      _$MostFollowedProfileImpl.fromJson;

  @override
  Profile? get profile;
  @override
  int? get followerCount;
  @override
  @JsonKey(ignore: true)
  _$$MostFollowedProfileImplCopyWith<_$MostFollowedProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
