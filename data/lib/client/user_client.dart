import 'package:domain/domain.dart';

abstract class UserClient {
  Future<User> getProfile();

  Future<void> signOut({String? deviceToken});

  Future<List<String>> registerDeviceToken({required String deviceToken});

  Future<List<String>> unregisterDeviceToken({required String deviceToken});

  Future<void> signIn(String email, String password);
}
