part of 'sms_verification_bloc.dart';

sealed class SmsVerificationEvent extends Equatable {
  const SmsVerificationEvent();

  @override
  List<Object> get props => [];
}

final class SmsVerificationResent extends SmsVerificationEvent {
  final String phone;

  const SmsVerificationResent({
    required this.phone,
  });
}

final class SmsVerificationVerified extends SmsVerificationEvent {
  final String phone;
  final String smsCode;
  final String verificationId;

  const SmsVerificationVerified({
    required this.phone,
    required this.smsCode,
    required this.verificationId,
  });
}
