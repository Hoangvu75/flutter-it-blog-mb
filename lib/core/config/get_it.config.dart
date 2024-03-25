// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../domain/repository/auth.repository.dart' as _i3;
import '../../domain/repository/follow.repository.dart' as _i4;
import '../../domain/repository/post.repository.dart' as _i5;
import '../../domain/repository/profile.repository.dart' as _i6;
import '../../domain/repository/topic.repository.dart' as _i8;
import '../../infrastructure/services/storage.service.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AuthRepository>(() => _i3.AuthRepository());
    gh.lazySingleton<_i4.FollowRepository>(() => _i4.FollowRepository());
    gh.lazySingleton<_i5.PostRepository>(() => _i5.PostRepository());
    gh.lazySingleton<_i6.ProfileRepository>(() => _i6.ProfileRepository());
    gh.lazySingleton<_i7.StorageService>(() => _i7.StorageService());
    gh.lazySingleton<_i8.TopicRepository>(() => _i8.TopicRepository());
    return this;
  }
}
