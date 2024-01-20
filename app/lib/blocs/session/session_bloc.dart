import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/blocs/mixins/mixins.dart';
import 'package:melodify/constants/constants.dart';

part 'session_event.dart';
part 'session_state.dart';

@LazySingleton()
class SessionBloc extends BaseBloc<SessionEvent, SessionState> with AppLoading {
  final AuthService _authService;
  final UserService _userService;
  final SessionService _sessionService;

  SessionBloc(
    AuthService authService,
    UserService userService,
    SessionService sessionService,
  )   : _authService = authService,
        _userService = userService,
        _sessionService = sessionService,
        super(Keys.Blocs.session, SessionInitial()) {
    on<SessionLoaded>(_onSessionLoaded);
    on<SessionUserSignedIn>(_onSessionUserSignedIn);
    on<SessionSignedOut>(_onSessionSignedOut);
  }

  @override
  List<Broadcast> subscribes() {
    return [
      Broadcast(
        blocKey: key,
        event: Keys.Broadcasts.authenticated,
        onNext: (data) {
          final User? user = data['user'];

          if (user == null) {
            add(const SessionLoaded());
            return;
          }

          add(SessionUserSignedIn(user));
        },
      )
    ];
  }

  Future<void> _onSessionUserSignedIn(
    SessionUserSignedIn event,
    Emitter<SessionState> emit,
  ) async {
    log.trace('SESSION USER SIGNED IN');
    emit(SessionSignInSuccess(user: event.signedInUser));
  }

  Future<void> _onSessionLoaded(
    SessionLoaded event,
    Emitter<SessionState> emit,
  ) async {
    try {
      log.trace('SESSION LOADED START');
      final firebaseToken = await _sessionService.getCurrentSession();
      if (firebaseToken == null) return emit(SessionLoadFailure());
      log.info('FIREBASE JWT ──> $firebaseToken');
      final user = await _userService.getProfile();
      emit(SessionSignInSuccess(user: user));
    } catch (e) {
      log.error('SESSION LOADED ──> $e');
      emit(SessionLoadFailure());
    }
  }

  Future<void> _onSessionSignedOut(
    SessionSignedOut event,
    Emitter<SessionState> emit,
  ) async {
    try {
      showLoading();
      await Future.wait([
        _authService.signOut(),
        _userService.signOut(),
        _userService.unregisterDeviceToken(),
      ]);

      emit(SessionSignOutSuccess());
    } catch (e) {
      log.error('SIGN OUT ERROR ──> $e');
      emit(SessionSignOutSuccess());
    } finally {
      hideLoading();
    }
  }
}
