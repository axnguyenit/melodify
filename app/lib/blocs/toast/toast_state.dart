part of 'toast_bloc.dart';

abstract class ToastState extends Equatable {
  final String message;
  final AlertSeverity severity;
  final List<dynamic> params;

  const ToastState({
    this.message = '',
    this.severity = AlertSeverity.info,
    this.params = const [],
  });

  @override
  List<Object> get props => [identityHashCode(this)];
}

class ToastInitial extends ToastState {}

class ToastShowSuccess extends ToastState {
  const ToastShowSuccess({
    required super.message,
    super.severity,
    super.params,
  });
}
