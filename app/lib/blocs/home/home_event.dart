part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeLoaded extends HomeEvent {}

final class HomeBrowsed extends HomeEvent {}
