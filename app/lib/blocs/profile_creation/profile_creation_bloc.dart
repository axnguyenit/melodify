import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/blocs/mixins/mixins.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';
import 'package:resources/resources.dart';

part 'profile_creation_event.dart';
part 'profile_creation_state.dart';

@Injectable()
class ProfileCreationBloc
    extends BaseBloc<ProfileCreationEvent, ProfileCreationState>
    with ToastShowing {
  final UserService _userService;
  final AuthService _authService;

  ProfileCreationBloc(this._userService, this._authService)
      : super(Keys.Blocs.profileCreation, ProfileCreationInitial()) {
    on<ProfileCreationSubmitted>(_onProfileCreationSubmitted);
  }

  Future<void> _onProfileCreationSubmitted(
    ProfileCreationSubmitted event,
    Emitter<ProfileCreationState> emit,
  ) async {
    try {
      emit(ProfileCreationSubmitInProgress());
      final ProfileCreationSubmitted(
        :email,
        :firstName,
        :lastName,
        :phone,
        :password
      ) = event;
      final isEmailExists = await _userService.emailAlreadyExists(email);
      if (isEmailExists) {
        emit(ProfileCreationSubmitFailure());
        return showWarningMessage(
          Strings.emailAlreadyExisted,
        );
      }

      final token = await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      log.warning(token);
      final deviceToken = await di.get<Messaging>().getDeviceToken;
      log.trace('FCM token -> $deviceToken');
      await _userService.createUserProfile(
        ProfileCreationRequest(
          email: email,
          phone: phone,
          role: UserRole.user,
          firstName: firstName,
          lastName: lastName,
        ),
      );
      final user = await _userService.getProfile();
      di.bloc<SessionBloc>().add(SessionUserSignedIn(user));
    } catch (e) {
      log.error(e);
      emit(ProfileCreationSubmitFailure());
    }
  }
}
