part of 'profile_creation_bloc.dart';

sealed class ProfileCreationEvent extends Equatable {
  const ProfileCreationEvent();

  @override
  List<Object> get props => [];
}

final class ProfileCreationSubmitted extends ProfileCreationEvent {
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String password;

  const ProfileCreationSubmitted({
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.password,
  });
}
