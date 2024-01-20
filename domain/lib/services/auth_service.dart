import 'package:domain/domain.dart';

abstract class AuthService {
  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<SMSVerification> signInWithPhone({required String phoneNumber});

  Future<String?> verifySMSCode({
    required String smsCode,
    required String verificationId,
  });

  Future<SMSVerification> resendSMS({required String phoneNumber});

  Future<String?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<bool> isAuthenticated();
}
