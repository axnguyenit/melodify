part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [identityHashCode(this)];
}

final class SignUpSubmitted extends SignUpEvent {
  final String phoneNumber;

  const SignUpSubmitted({
    required this.phoneNumber,
  });
}
