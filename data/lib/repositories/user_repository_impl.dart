import 'package:data/client/client.dart';
import 'package:data/dao/dao.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserDao _userDao;
  final UserClient _userClient;

  UserRepositoryImpl(
    UserDao userDao,
    UserClient userClient,
  )   : _userDao = userDao,
        _userClient = userClient;

  @override
  Future<User> getProfile() async {
    return _userClient.getProfile();
  }

  @override
  Future<void> saveUser(User user, {Authorization? authorization}) async {
    await _userDao.saveUser(user);

    if (authorization != null) {
      await _userDao.saveAuthorization(authorization);
    }
  }

  @override
  User? getLoggedInUser({bool forceToUpdate = false}) {
    return _userDao.loadUser();
  }

  @override
  Future<User> getLatestLoggedInUser() async {
    final user = await _userClient.getProfile();
    await _userDao.saveUser(user);
    return user;
  }

  @override
  Authorization? getLoggedInAuthorization() {
    return _userDao.loadAuthorization();
  }

  @override
  Future<void> signOut({String? deviceToken}) async {
    await _userDao.clearAuthentication();
    await _userClient.signOut(deviceToken: deviceToken);
  }

  @override
  Future<void> clearAuthentication() {
    return _userDao.clearAuthentication();
  }

  @override
  String? getRegisteredDeviceToken() {
    return _userDao.getRegisteredDeviceToken();
  }

  @override
  Future<List<String>> registerDeviceToken(
      {required String deviceToken}) async {
    final deviceTokens = await _userClient.registerDeviceToken(
      deviceToken: deviceToken,
    );

    if (deviceTokens.isNotEmpty) {
      await _userDao.saveRegisteredDeviceToken(deviceToken: deviceToken);
    }

    return deviceTokens;
  }

  @override
  Future<void> unregisterDeviceToken() async {
    final registeredDeviceToken = _userDao.getRegisteredDeviceToken();
    if (registeredDeviceToken == null) return;

    final tokens = await _userClient.unregisterDeviceToken(
      deviceToken: registeredDeviceToken,
    );
    if (!tokens.contains(registeredDeviceToken)) {
      await _userDao.clearDeviceToken();
    }
  }

  @override
  Future<void> signIn(String email, String password) {
    return _userClient.signIn(email, password);
  }
}
