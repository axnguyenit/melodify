import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/di/di.dart';
import 'package:domain/domain.dart';

mixin SessionData {
  bool get isGuest => _sessionState.signedInUser == null;

  bool get authenticated => _sessionState.signedInUser != null;

  SessionState get _sessionState => di.get<SessionBloc>().state;

  /// Make sure you only access [authUser] after authenticating
  User get authUser => _sessionState.signedInUser!;
}
