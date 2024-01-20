import 'package:domain/domain.dart';

abstract class UserRepository {
  Future<User> getProfile();

  Future<void> signOut({String? deviceToken});

  Future<void> saveUser(User user, {Authorization? authorization});

  Future<void> clearAuthentication();

  User? getLoggedInUser();

  Future<User> getLatestLoggedInUser();

  Authorization? getLoggedInAuthorization();

  String? getRegisteredDeviceToken();

  Future<List<String>> registerDeviceToken({required String deviceToken});

  Future<void> unregisterDeviceToken();

  Future<void> signIn(String email, String password);
}
