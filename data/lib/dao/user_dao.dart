import 'package:domain/domain.dart';

abstract class UserDao {
  Future<void> saveUser(User user);

  Future<void> saveAuthorization(Authorization authorization);

  User? loadUser();

  Authorization? loadAuthorization();

  Future<void> saveRegisteredDeviceToken({required String deviceToken});

  String? getRegisteredDeviceToken();

  Future<void> clearAuthentication();

  Future<void> clearDeviceToken();
}
