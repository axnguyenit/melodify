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
import 'package:melodify/blocs/language/language_bloc.dart' as _i4;
import 'package:melodify/blocs/loading/loading_bloc.dart' as _i6;
import 'package:melodify/blocs/profile_creation/profile_creation_bloc.dart'
    as _i9;
import 'package:melodify/blocs/query_suggestion/query_suggestion_bloc.dart'
    as _i10;
import 'package:melodify/blocs/session/session_bloc.dart' as _i11;
import 'package:melodify/blocs/sign_in/sign_in_bloc.dart' as _i12;
import 'package:melodify/blocs/sign_up/sign_up_bloc.dart' as _i13;
import 'package:melodify/blocs/sms_verification/sms_verification_bloc.dart'
    as _i14;
import 'package:melodify/blocs/toast/toast_bloc.dart' as _i15;
import 'package:melodify/global/local_notification.dart' as _i7;
import 'package:melodify/global/messaging.dart' as _i8;

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
    gh.lazySingleton<_i4.LanguageBloc>(
        () => _i4.LanguageBloc(gh<_i5.SettingsService>()));
    gh.lazySingleton<_i6.LoadingBloc>(() => _i6.LoadingBloc());
    gh.lazySingleton<_i7.LocalNotification>(() => _i7.LocalNotification());
    gh.lazySingleton<_i8.Messaging>(() => _i8.Messaging());
    gh.factory<_i9.ProfileCreationBloc>(() => _i9.ProfileCreationBloc(
          gh<_i5.UserService>(),
          gh<_i5.AuthService>(),
        ));
    gh.factory<_i10.QuerySuggestionBloc>(
        () => _i10.QuerySuggestionBloc(gh<_i5.QuerySuggestionService>()));
    gh.lazySingleton<_i11.SessionBloc>(() => _i11.SessionBloc(
          gh<_i5.AuthService>(),
          gh<_i5.UserService>(),
          gh<_i5.SessionService>(),
          gh<_i5.YoutubeMusicService>(),
        ));
    gh.factory<_i12.SignInBloc>(() => _i12.SignInBloc(
          gh<_i5.AuthService>(),
          gh<_i5.UserService>(),
        ));
    gh.factory<_i13.SignUpBloc>(() => _i13.SignUpBloc(gh<_i5.AuthService>()));
    gh.factory<_i14.SmsVerificationBloc>(() => _i14.SmsVerificationBloc(
          gh<_i5.AuthService>(),
          gh<_i5.UserService>(),
        ));
    gh.lazySingleton<_i15.ToastBloc>(() => _i15.ToastBloc());
    return this;
  }
}
