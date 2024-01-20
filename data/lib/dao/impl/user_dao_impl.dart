import 'package:data/dao/base_dao.dart';
import 'package:data/dao/dao.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

const _userKey = 'key_current_user';
const _authorizationKey = 'key_current_authorization';
const _registeredDeviceTokenKey = 'key_registered_device_token';

@Injectable(as: UserDao)
class UserDaoImpl extends BaseDao<User> implements UserDao {
  UserDaoImpl({required super.preferences})
      : super(mapper: Mapper<User>(parser: User.fromJson));

  @override
  Future<void> saveUser(User user) {
    return saveItem(_userKey, user);
  }

  @override
  Future<void> saveAuthorization(Authorization authorization) async {
    await saveEntity<Authorization>(_authorizationKey, authorization);
  }

  @override
  User? loadUser() {
    return getItem(_userKey);
  }

  @override
  Authorization? loadAuthorization() {
    final authorization = getEntity<Authorization>(
      _authorizationKey,
      mapper: Mapper<Authorization>(
        parser: Authorization.fromJson,
      ),
    );
    if (authorization == null) {
      return null;
    }

    return authorization;
  }

  @override
  String? getRegisteredDeviceToken() {
    return getString(_registeredDeviceTokenKey);
  }

  @override
  Future<void> saveRegisteredDeviceToken({required String deviceToken}) {
    return saveString(deviceToken, _registeredDeviceTokenKey);
  }

  @override
  Future<void> clearAuthentication() async {
    await Future.wait([
      clearObjectOrEntity(_userKey),
      clearObjectOrEntity(_authorizationKey)
    ]);
  }

  @override
  Future<void> clearDeviceToken() async {
    await clearObjectOrEntity(_registeredDeviceTokenKey);
  }
}
