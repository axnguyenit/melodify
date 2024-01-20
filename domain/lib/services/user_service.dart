import 'package:domain/domain.dart';

abstract class UserService {
  Future<User> getProfile();

  void registerDeviceTokenIfNeeded({
    required String deviceToken,
    bool forceUpToDate,
  });

  Future<void> unregisterDeviceToken();

  Future<void> signOut();

  Future<void> signIn(String email, String password);

  Future<bool> emailAlreadyExists(String email);

  Future<User> createUserProfile(ProfileCreationRequest request);

  Future<bool> isEmailAlreadyExists(String email);

  Future<bool> isPhoneAlreadyExists(String phone);

  Future<User?> getUserById(String id);
}
