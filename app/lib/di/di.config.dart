// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/domain.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:melodify/blocs/connectivity/connectivity_bloc.dart' as _i4;
import 'package:melodify/blocs/home/home_bloc.dart' as _i5;
import 'package:melodify/blocs/language/language_bloc.dart' as _i7;
import 'package:melodify/blocs/loading/loading_bloc.dart' as _i8;
import 'package:melodify/blocs/profile_creation/profile_creation_bloc.dart'
    as _i11;
import 'package:melodify/blocs/query_suggestion/query_suggestion_bloc.dart'
    as _i12;
import 'package:melodify/blocs/session/session_bloc.dart' as _i13;
import 'package:melodify/blocs/sign_in/sign_in_bloc.dart' as _i14;
import 'package:melodify/blocs/sign_up/sign_up_bloc.dart' as _i15;
import 'package:melodify/blocs/sms_verification/sms_verification_bloc.dart'
    as _i16;
import 'package:melodify/blocs/toast/toast_bloc.dart' as _i17;
import 'package:melodify/blocs/video_details/video_details_bloc.dart' as _i18;
import 'package:melodify/blocs/youtube/youtube_bloc.dart' as _i19;
import 'package:melodify/global/audio_handler.dart' as _i3;
import 'package:melodify/global/local_notification.dart' as _i9;
import 'package:melodify/global/messaging.dart' as _i10;

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
    gh.lazySingleton<_i3.AppAudioHandler>(() => _i3.AppAudioHandler());
    gh.lazySingleton<_i4.ConnectivityBloc>(() => _i4.ConnectivityBloc());
    gh.lazySingleton<_i5.HomeBloc>(
        () => _i5.HomeBloc(gh<_i6.YoutubeMusicService>()));
    gh.lazySingleton<_i7.LanguageBloc>(
        () => _i7.LanguageBloc(gh<_i6.SettingsService>()));
    gh.lazySingleton<_i8.LoadingBloc>(() => _i8.LoadingBloc());
    gh.lazySingleton<_i9.LocalNotification>(() => _i9.LocalNotification());
    gh.lazySingleton<_i10.Messaging>(() => _i10.Messaging());
    gh.factory<_i11.ProfileCreationBloc>(() => _i11.ProfileCreationBloc(
          gh<_i6.UserService>(),
          gh<_i6.AuthService>(),
        ));
    gh.factory<_i12.QuerySuggestionBloc>(
        () => _i12.QuerySuggestionBloc(gh<_i6.QuerySuggestionService>()));
    gh.lazySingleton<_i13.SessionBloc>(() => _i13.SessionBloc(
          gh<_i6.AuthService>(),
          gh<_i6.UserService>(),
          gh<_i6.SessionService>(),
        ));
    gh.factory<_i14.SignInBloc>(() => _i14.SignInBloc(
          gh<_i6.AuthService>(),
          gh<_i6.UserService>(),
        ));
    gh.factory<_i15.SignUpBloc>(() => _i15.SignUpBloc(gh<_i6.AuthService>()));
    gh.factory<_i16.SmsVerificationBloc>(() => _i16.SmsVerificationBloc(
          gh<_i6.AuthService>(),
          gh<_i6.UserService>(),
        ));
    gh.lazySingleton<_i17.ToastBloc>(() => _i17.ToastBloc());
    gh.lazySingleton<_i18.VideoDetailsBloc>(
        () => _i18.VideoDetailsBloc(gh<_i6.YoutubeMusicService>()));
    gh.lazySingleton<_i19.YoutubeBloc>(() => _i19.YoutubeBloc());
    return this;
  }
}
