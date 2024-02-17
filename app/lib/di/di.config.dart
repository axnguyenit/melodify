// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/domain.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:melodify/blocs/connectivity/connectivity_bloc.dart' as _i3;
import 'package:melodify/blocs/home/home_bloc.dart' as _i4;
import 'package:melodify/blocs/language/language_bloc.dart' as _i6;
import 'package:melodify/blocs/loading/loading_bloc.dart' as _i7;
import 'package:melodify/blocs/profile_creation/profile_creation_bloc.dart'
    as _i10;
import 'package:melodify/blocs/query_suggestion/query_suggestion_bloc.dart'
    as _i11;
import 'package:melodify/blocs/session/session_bloc.dart' as _i12;
import 'package:melodify/blocs/sign_in/sign_in_bloc.dart' as _i13;
import 'package:melodify/blocs/sign_up/sign_up_bloc.dart' as _i14;
import 'package:melodify/blocs/sms_verification/sms_verification_bloc.dart'
    as _i15;
import 'package:melodify/blocs/toast/toast_bloc.dart' as _i16;
import 'package:melodify/global/local_notification.dart' as _i8;
import 'package:melodify/global/messaging.dart' as _i9;

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
    gh.lazySingleton<_i3.ConnectivityBloc>(() => _i3.ConnectivityBloc());
    gh.lazySingleton<_i4.HomeBloc>(
        () => _i4.HomeBloc(gh<_i5.YoutubeMusicService>()));
    gh.lazySingleton<_i6.LanguageBloc>(
        () => _i6.LanguageBloc(gh<_i5.SettingsService>()));
    gh.lazySingleton<_i7.LoadingBloc>(() => _i7.LoadingBloc());
    gh.lazySingleton<_i8.LocalNotification>(() => _i8.LocalNotification());
    gh.lazySingleton<_i9.Messaging>(() => _i9.Messaging());
    gh.factory<_i10.ProfileCreationBloc>(() => _i10.ProfileCreationBloc(
          gh<_i5.UserService>(),
          gh<_i5.AuthService>(),
        ));
    gh.factory<_i11.QuerySuggestionBloc>(
        () => _i11.QuerySuggestionBloc(gh<_i5.QuerySuggestionService>()));
    gh.lazySingleton<_i12.SessionBloc>(() => _i12.SessionBloc(
          gh<_i5.AuthService>(),
          gh<_i5.UserService>(),
          gh<_i5.SessionService>(),
        ));
    gh.factory<_i13.SignInBloc>(() => _i13.SignInBloc(
          gh<_i5.AuthService>(),
          gh<_i5.UserService>(),
        ));
    gh.factory<_i14.SignUpBloc>(() => _i14.SignUpBloc(gh<_i5.AuthService>()));
    gh.factory<_i15.SmsVerificationBloc>(() => _i15.SmsVerificationBloc(
          gh<_i5.AuthService>(),
          gh<_i5.UserService>(),
        ));
    gh.lazySingleton<_i16.ToastBloc>(() => _i16.ToastBloc());
    return this;
  }
}
