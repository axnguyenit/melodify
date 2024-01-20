part of 'loading_bloc.dart';

abstract class LoadingEvent extends Equatable {
  const LoadingEvent();

  @override
  List<Object> get props => [];
}

class LoadingStated extends LoadingEvent {}

class LoadingStopped extends LoadingEvent {}
