part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  final User? signedInUser;
  final DateTime updatedDate;

  SessionState([this.signedInUser]) : updatedDate = DateTime.now();

  @override
  List<Object?> get props => [updatedDate];
}

class SessionInitial extends SessionState {
  SessionInitial() : super();
}

class SessionSignInSuccess extends SessionState {
  SessionSignInSuccess({
    required User user,
  }) : super(user);
}

class SessionLoadFailure extends SessionState {
  SessionLoadFailure() : super();
}

class SessionSignOutSuccess extends SessionState {
  SessionSignOutSuccess() : super();
}
