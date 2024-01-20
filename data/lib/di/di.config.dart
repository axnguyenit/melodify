// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:data/client/client.dart' as _i10;
import 'package:data/client/impl/user_client_impl.dart' as _i11;
import 'package:data/dao/dao.dart' as _i4;
import 'package:data/dao/impl/settings_dao_impl.dart' as _i7;
import 'package:data/dao/impl/user_dao_impl.dart' as _i5;
import 'package:data/di/data_module.dart' as _i13;
import 'package:data/preferences/app_references.dart' as _i6;
import 'package:data/repositories/settings_repository_impl.dart' as _i9;
import 'package:data/repositories/user_repository_impl.dart' as _i12;
import 'package:domain/domain.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

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
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => dataModule.prefs,
      preResolve: true,
    );
    gh.factory<_i4.UserDao>(
        () => _i5.UserDaoImpl(preferences: gh<_i3.SharedPreferences>()));
    gh.lazySingleton<_i6.AppPreferences>(
        () => _i6.AppPreferences(gh<_i3.SharedPreferences>()));
    gh.factory<_i4.SettingsDao>(
        () => _i7.SettingsDaoImpl(preferences: gh<_i3.SharedPreferences>()));
    gh.factory<_i8.SettingsRepository>(
        () => _i9.SettingsRepositoryImpl(gh<_i4.SettingsDao>()));
    gh.lazySingleton<_i10.UserClient>(
        () => _i11.UserClientImpl(gh<_i6.AppPreferences>()));
    gh.factory<_i8.UserRepository>(() => _i12.UserRepositoryImpl(
          gh<_i4.UserDao>(),
          gh<_i10.UserClient>(),
        ));
    return this;
  }
}

class _$DataModule extends _i13.DataModule {}
