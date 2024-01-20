import 'package:json_annotation/json_annotation.dart';

final _userRoleMap = <String, UserRole>{
  'USER': UserRole.user,
  'ADMIN': UserRole.admin,
};

const _userRoleEnumMap = {
  UserRole.user: 'USER',
  UserRole.admin: 'ADMIN',
};

enum UserRole {
  @JsonValue('USER')
  user,
  @JsonValue('ADMIN')
  admin;

  factory UserRole.fromValue(String? value) {
    return _userRoleMap[value] ?? UserRole.user;
  }

  String get value => _userRoleEnumMap[this]!;
}
