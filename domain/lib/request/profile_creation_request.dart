import 'package:domain/domain.dart';

class ProfileCreationRequest {
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final UserRole role;
  final DateTime lastOnlineAt;
  final DateTime createdAt;

  ProfileCreationRequest({
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.role,
  })  : lastOnlineAt = DateTime.now(),
        createdAt = DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'first_name': firstName,
      'last_name': lastName,
      'last_online_at': lastOnlineAt,
      'role': role.value,
      'created_at': createdAt,
    };
  }
}
