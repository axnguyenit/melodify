// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/domain.dart' as _i3;
import 'package:domain/services/impl/auth_service_impl.dart' as _i4;
import 'package:domain/services/impl/music_service_impl.dart' as _i5;
import 'package:domain/services/impl/query_suggestion_service_impl.dart' as _i6;
import 'package:domain/services/impl/session_service_impl.dart' as _i7;
import 'package:domain/services/impl/settings_service_impl.dart' as _i8;
import 'package:domain/services/impl/user_service_impl.dart' as _i9;
import 'package:domain/services/impl/youtube_music_service_impl.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

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
    gh.factory<_i3.AuthService>(() => _i4.AuthServiceImpl());
    gh.lazySingleton<_i3.MusicService>(() => _i5.MusicServiceImpl());
    gh.factory<_i3.QuerySuggestionService>(() =>
        _i6.QuerySuggestionServiceImpl(gh<_i3.QuerySuggestionRepository>()));
    gh.factory<_i3.SessionService>(() => _i7.SessionServiceImpl());
    gh.factory<_i3.SettingsService>(
        () => _i8.SettingsServiceImpl(gh<_i3.SettingsRepository>()));
    gh.factory<_i3.UserService>(
        () => _i9.UserServiceImpl(gh<_i3.UserRepository>()));
    gh.lazySingleton<_i3.YoutubeMusicService>(
        () => _i10.YoutubeMusicServiceImpl(gh<_i3.YoutubeMusicRepository>()));
    return this;
  }
}
