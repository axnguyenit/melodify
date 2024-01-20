part of 'sign_in_bloc.dart';

enum SignInError {
  invalidEmail,
  invalidPassword,
  userNotFound,
  tooManyRequest,
  unknown;

  factory SignInError.fromCode(String? code) {
    final literalObj = {
      'user-not-found': SignInError.userNotFound,
      'invalid-credential': SignInError.userNotFound,
      'wrong-password': SignInError.invalidPassword,
      'too-many-requests': SignInError.tooManyRequest,
    };

    return literalObj[code] ?? SignInError.unknown;
  }

  bool get isInvalidPassword => this == SignInError.invalidPassword;

  bool get isUserNotFound => this == SignInError.userNotFound;

  bool get isTooManyRequest => this == SignInError.tooManyRequest;
}

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [identityHashCode(this)];
}

class SignInInitial extends SignInState {}

class SignInSubmitInProgress extends SignInState {}

class SignInSubmitSuccess extends SignInState {}

class SignInSubmitFailure extends SignInState {
  final SignInError error;

  const SignInSubmitFailure({this.error = SignInError.unknown});
}
