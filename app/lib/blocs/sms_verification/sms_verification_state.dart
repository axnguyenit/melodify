part of 'sms_verification_bloc.dart';

sealed class SmsVerificationState extends Equatable {
  const SmsVerificationState();

  @override
  List<Object> get props => [];
}

final class SmsVerificationInitial extends SmsVerificationState {}

// ════════════════════════════════════════════
final class SmsVerificationVerifyInProgress extends SmsVerificationState {}

final class SmsVerificationVerifySuccess extends SmsVerificationState {}

final class SmsVerificationVerifyFailure extends SmsVerificationState {}

// ════════════════════════════════════════════
final class SmsVerificationResendInProgress extends SmsVerificationState {}

final class SmsVerificationResendSuccess extends SmsVerificationState {
  final String verificationId;

  const SmsVerificationResendSuccess({
    required this.verificationId,
  });
}

final class SmsVerificationResendFailure extends SmsVerificationState {}
