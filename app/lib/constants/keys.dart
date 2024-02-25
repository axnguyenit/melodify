// ignore_for_file: library_private_types_in_public_api,
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';

class Keys {
  Keys._();

  static _Blocs get Blocs => _Blocs();

  static _Broadcasts get Broadcasts => _Broadcasts();
}

class _Broadcasts {
  static final _singleton = _Broadcasts._internal();

  factory _Broadcasts() {
    return _singleton;
  }

  _Broadcasts._internal();

  final String authenticated = 'authenticated_broadcast';

  final String signOutSuccess = 'sign_out_success_broadcast';
}

class _Blocs {
  static final _Blocs _singleton = _Blocs._internal();

  factory _Blocs() {
    return _singleton;
  }

  _Blocs._internal();

  /// One instance at the given time
  /// ────────────────────────────────────────────
  final noneDispose = const Key('none_dispose_bloc');
  final forceToDispose = const Key('force_to_dispose_bloc');

  /// BASE
  final connectivity = const Key('connectivity_bloc');
  final loading = const Key('loading_bloc');
  final language = const Key('language_bloc');
  final session = const Key('session_bloc');

  final signIn = const Key('sign_in_bloc');
  final toast = const Key('toast_bloc');
  final signUp = const Key('sign_up_bloc');
  final smsVerification = const Key('sms_verification_bloc');
  final profileCreation = const Key('profile_creation_bloc');
  final querySuggestion = const Key('query_suggestion_bloc');
  final home = const Key('home_bloc');
  final youtube = const Key('youtube_bloc');
  final videoDetails = const Key('video_details_bloc');
}
