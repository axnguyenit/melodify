import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/blocs/mixins/mixins.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/di/di.dart';

part 'sms_verification_event.dart';
part 'sms_verification_state.dart';

@Injectable()
class SmsVerificationBloc
    extends BaseBloc<SmsVerificationEvent, SmsVerificationState>
    with AppLoading {
  final AuthService _authService;
  final UserService _userService;

  SmsVerificationBloc(this._authService, this._userService)
      : super(Keys.Blocs.smsVerification, SmsVerificationInitial()) {
    on<SmsVerificationVerified>(_onSmsVerificationVerified);
    on<SmsVerificationResent>(_onSmsVerificationResent);
  }

  Future<void> _onSmsVerificationVerified(
    SmsVerificationVerified event,
    Emitter<SmsVerificationState> emit,
  ) async {
    try {
      showLoading();
      final SmsVerificationVerified(:phone, :smsCode, :verificationId) = event;
      emit(SmsVerificationVerifyInProgress());
      await _authService.verifySMSCode(
        smsCode: smsCode,
        verificationId: verificationId,
      );
      final isExists = await _userService.isPhoneAlreadyExists(phone);
      if (isExists) {
        final user = await _userService.getProfile();
        di.bloc<SessionBloc>().add(SessionUserSignedIn(user));
        return;
      }
      emit(SmsVerificationVerifySuccess());
    } catch (e) {
      log.error(e);
      emit(SmsVerificationVerifyFailure());
    } finally {
      hideLoading();
    }
  }

  Future<void> _onSmsVerificationResent(
    SmsVerificationResent event,
    Emitter<SmsVerificationState> emit,
  ) async {
    try {
      showLoading();
      emit(SmsVerificationResendInProgress());
      final smsVerification = await _authService.resendSMS(
        phoneNumber: event.phone,
      );
      final SMSVerification(:verificationId) = smsVerification;

      emit(SmsVerificationResendSuccess(
        verificationId: verificationId!,
      ));
    } catch (e) {
      // invalid-verification-code
      log.error(e);
      emit(SmsVerificationResendFailure());
    } finally {
      hideLoading();
    }
  }
}
