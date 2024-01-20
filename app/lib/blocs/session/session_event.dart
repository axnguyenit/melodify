part of 'session_bloc.dart';

abstract class SessionEvent {
  const SessionEvent();
}

class SessionUserSignedIn extends SessionEvent {
  final User signedInUser;

  SessionUserSignedIn(this.signedInUser);
}

class SessionLoaded extends SessionEvent {
  const SessionLoaded();
}

class SessionSignedOut extends SessionEvent {
  const SessionSignedOut();
}
