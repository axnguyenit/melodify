import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/di/di.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

@Injectable()
class SignInBloc extends BaseBloc<SignInEvent, SignInState> {
  final AuthService _authService;
  final UserService _userService;

  SignInBloc(
    AuthService authService,
    UserService userService,
  )   : _authService = authService,
        _userService = userService,
        super(Keys.Blocs.signIn, SignInInitial()) {
    on<SignInSubmitted>(_onSignInSubmitted);
  }

  Future _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    try {
      final token = await _authService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      log.info(token);
      if (token == null) {}
      final user = await _userService.getProfile();

      di.broadcast(
        Keys.Broadcasts.authenticated,
        params: {'user': user},
      );
    } catch (e) {
      log.error(e);
      if (e is FirebaseException) {
        return emit(SignInSubmitFailure(error: SignInError.fromCode(e.code)));
      }
      emit(const SignInSubmitFailure());
    }
  }
}
