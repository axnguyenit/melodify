import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';

class User extends Model {
  final String id;
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final UserRole role;
  final DateTime lastOnlineAt;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.lastOnlineAt,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      role: UserRole.fromValue(json['role']),
      lastOnlineAt: (json['last_online_at'] as Timestamp).toDate(),
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {};

  @override
  List<Object> get props => [id];
}
