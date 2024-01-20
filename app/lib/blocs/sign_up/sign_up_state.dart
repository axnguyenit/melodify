part of 'sign_up_bloc.dart';

final _map = {
  // 'email-already-exists': SignUpError.emailAlreadyExists,
  'invalid-phone-number': SignUpError.invalidPhoneNumber,
  'phone-number-already-exists': SignUpError.phoneAlreadyExists,
};

enum SignUpError {
  phoneAlreadyExists,
  invalidPhoneNumber,
  unknown;

  factory SignUpError.fromCode(String? code) {
    return _map[code] ?? SignUpError.unknown;
  }

  bool get isPhoneAlreadyExists => this == SignUpError.phoneAlreadyExists;

  bool get isInvalidPhoneNumber => this == SignUpError.invalidPhoneNumber;
}

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [identityHashCode(this)];
}

final class SignUpInitial extends SignUpState {}

final class SignUpSubmitInProgress extends SignUpState {}

final class SignUpSubmitSuccess extends SignUpState {
  final String verificationId;

  const SignUpSubmitSuccess({
    required this.verificationId,
  });
}

final class SignUpSubmitFailure extends SignUpState {
  final SignUpError error;

  const SignUpSubmitFailure({this.error = SignUpError.unknown});
}
