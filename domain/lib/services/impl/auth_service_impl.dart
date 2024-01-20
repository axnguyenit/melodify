import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthService)
class AuthServiceImpl implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log.info('Login done credential ──> ${credential.user}');
      return credential.user?.getIdToken();
    } catch (e) {
      if (e is FirebaseAuthException) {
        // if (e.code == 'user-not-found') {
        //   throw AuthenticationWrongEmailException(e.message);
        // } else if (e.code == 'wrong-password') {
        //   throw AuthenticationWrongPasswordException(e.message);
        // }
      }
      rethrow;
    }
  }

  @override
  Future<SMSVerification> signInWithPhone({required String phoneNumber}) async {
    final completer = Completer<SMSVerification>();

    unawaited(_auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY
        log.info('CREDENTIAL ──> $credential');
        final userCredential = await _auth.signInWithCredential(credential);
        log.info('userCredential ──> $userCredential');
      },
      verificationFailed: completer.completeError,
      codeSent: (String verificationId, int? resendToken) {
        log.info('AUTH SERVICE CODE SENT ──> $verificationId ──> $resendToken');

        if (!completer.isCompleted) {
          completer.complete(
            SMSVerification(
              phoneNumber: phoneNumber,
              verificationId: verificationId,
            ),
          );
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (!completer.isCompleted) {
          completer.complete(
            SMSVerification(
              phoneNumber: phoneNumber,
              verificationId: verificationId,
            ),
          );
        }
      },
    ));

    return completer.future;
  }

  @override
  Future<String?> verifySMSCode({
    required String smsCode,
    required String verificationId,
  }) async {
    final authCredential = PhoneAuthProvider.credential(
      smsCode: smsCode,
      verificationId: verificationId,
    );

    final userCredential = await _auth.signInWithCredential(authCredential);
    final token = userCredential.user!.getIdToken();
    // log.info('TOKEN ──> $token');

    return token;
  }

  @override
  Future<SMSVerification> resendSMS({required String phoneNumber}) async {
    return signInWithPhone(phoneNumber: phoneNumber);
  }

  @override
  Future<String?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    log.trace(_auth.currentUser);
    if (_auth.currentUser == null) {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user?.getIdToken();
    }

    final userCredential = await _auth.currentUser!.linkWithCredential(
      EmailAuthProvider.credential(
        email: email,
        password: password,
      ),
    );

    return userCredential.user?.getIdToken();
    // } on FirebaseAuthException catch (e) {
    //   switch (e.code) {
    //     case 'provider-already-linked':
    //       log.error('The provider has already been linked to the user.');
    //       break;
    //     case 'invalid-credential':
    //       log.error('The provider\'s credential is not valid.');
    //       break;
    //     case 'credential-already-in-use':
    //       log.error(
    //           '''The account corresponding to the credential already exists,
    //           or is already linked to a Firebase User.''');
    //       break;
    //     // See the API reference for the full list of error codes.
    //     default:
    //       log.error('Unknown error.');
    //   }
    //   return credential.accessToken;
    // } catch (e) {
    //   log.error('Firebase Error ──> $e');
    //   rethrow;
    // }
  }

  @override
  Future<bool> isAuthenticated() async {
    return _auth.currentUser != null;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
