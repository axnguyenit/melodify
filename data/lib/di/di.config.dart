// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:data/client/client.dart' as _i3;
import 'package:data/client/impl/query_suggestion_client_impl.dart' as _i4;
import 'package:data/client/impl/user_client_impl.dart' as _i15;
import 'package:data/client/impl/youtube_music_client_impl.dart' as _i10;
import 'package:data/dao/dao.dart' as _i8;
import 'package:data/dao/impl/settings_dao_impl.dart' as _i13;
import 'package:data/dao/impl/user_dao_impl.dart' as _i9;
import 'package:data/di/data_module.dart' as _i17;
import 'package:data/preferences/app_references.dart' as _i12;
import 'package:data/repositories/query_suggestion_repository_impl.dart' as _i6;
import 'package:data/repositories/settings_repository_impl.dart' as _i14;
import 'package:data/repositories/user_repository_impl.dart' as _i16;
import 'package:data/repositories/youtube_music_repository_impl.dart' as _i11;
import 'package:domain/domain.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dataModule = _$DataModule();
    gh.lazySingleton<_i3.QuerySuggestionClient>(
        () => _i4.QuerySuggestionClientImpl());
    gh.factory<_i5.QuerySuggestionRepository>(() =>
        _i6.QuerySuggestionRepositoryImpl(gh<_i3.QuerySuggestionClient>()));
    await gh.factoryAsync<_i7.SharedPreferences>(
      () => dataModule.prefs,
      preResolve: true,
    );
    gh.factory<_i8.UserDao>(
        () => _i9.UserDaoImpl(preferences: gh<_i7.SharedPreferences>()));
    gh.lazySingleton<_i3.YoutubeMusicClient>(
        () => _i10.YoutubeMusicClientImpl());
    gh.lazySingleton<_i5.YoutubeMusicRepository>(
        () => _i11.YoutubeMusicRepositoryImpl(gh<_i3.YoutubeMusicClient>()));
    gh.lazySingleton<_i12.AppPreferences>(
        () => _i12.AppPreferences(gh<_i7.SharedPreferences>()));
    gh.factory<_i8.SettingsDao>(
        () => _i13.SettingsDaoImpl(preferences: gh<_i7.SharedPreferences>()));
    gh.factory<_i5.SettingsRepository>(
        () => _i14.SettingsRepositoryImpl(gh<_i8.SettingsDao>()));
    gh.lazySingleton<_i3.UserClient>(
        () => _i15.UserClientImpl(gh<_i12.AppPreferences>()));
    gh.factory<_i5.UserRepository>(() => _i16.UserRepositoryImpl(
          gh<_i8.UserDao>(),
          gh<_i3.UserClient>(),
        ));
    return this;
  }
}

class _$DataModule extends _i17.DataModule {}
