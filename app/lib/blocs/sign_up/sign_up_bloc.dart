import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/constants/constants.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

@Injectable()
class SignUpBloc extends BaseBloc<SignUpEvent, SignUpState> {
  final AuthService _authService;

  SignUpBloc(this._authService) : super(Keys.Blocs.signUp, SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      emit(SignUpSubmitInProgress());
      final smsVerification = await _authService.signInWithPhone(
        phoneNumber: event.phoneNumber,
      );
      final SMSVerification(:verificationId) = smsVerification;
      emit(SignUpSubmitSuccess(verificationId: verificationId!));
    } catch (e) {
      log.error(e);
      if (e is FirebaseException) {
        return emit(SignUpSubmitFailure(error: SignUpError.fromCode(e.code)));
      }
      emit(const SignUpSubmitFailure());
    }
  }
}
