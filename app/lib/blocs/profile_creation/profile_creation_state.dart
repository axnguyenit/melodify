part of 'profile_creation_bloc.dart';

sealed class ProfileCreationState extends Equatable {
  const ProfileCreationState();

  @override
  List<Object> get props => [];
}

final class ProfileCreationInitial extends ProfileCreationState {}

// ════════════════════════════════════════════
final class ProfileCreationSubmitInProgress extends ProfileCreationState {}

final class ProfileCreationSubmitSuccess extends ProfileCreationState {}

final class ProfileCreationSubmitFailure extends ProfileCreationState {}
