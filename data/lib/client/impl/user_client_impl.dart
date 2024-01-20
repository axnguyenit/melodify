import 'package:data/client/base_client.dart';
import 'package:data/client/client.dart';
import 'package:data/configs/config.dart';
import 'package:data/preferences/app_references.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserClient)
class UserClientImpl extends BaseClient implements UserClient {
  UserClientImpl(AppPreferences appPreferences)
      : super(Config().baseUrl, appPreferences);

  @override
  Future<User> getProfile() async {
    final json = await get('/api/$apiVersion/users/profile');
    return User.fromJson(json['user']);
  }

  @override
  Future<void> signOut({String? deviceToken}) {
    final data = {'deviceToken': deviceToken ?? ''};
    return post('/api/$apiVersion/users/sign-out', data: data);
  }

  @override
  Future<List<String>> registerDeviceToken({
    required String deviceToken,
  }) async {
    final data = {'deviceToken': deviceToken};

    final json = await post(
      '/api/$apiVersion/users/register-device-token',
      data: data,
    );
    return (json['deviceTokens'] as List<dynamic>)
        .map((e) => e.toString())
        .toList();
  }

  @override
  Future<List<String>> unregisterDeviceToken(
      {required String deviceToken}) async {
    final json = await post('/api/$apiVersion/users/unregister-device-token',
        data: {'deviceToken': deviceToken});

    return (json['deviceTokens'] as List<dynamic>)
        .map((e) => e.toString())
        .toList();
  }

  @override
  Future<void> signIn(String email, String password) async {
    await post('/api/$apiVersion/auth/sign-in');
  }
}
