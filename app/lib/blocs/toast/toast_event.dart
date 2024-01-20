part of 'toast_bloc.dart';

abstract class ToastEvent extends Equatable {
  const ToastEvent();

  @override
  List<Object> get props => [identityHashCode(this)];
}

class ToastShowed extends ToastEvent {
  final String message;
  final List<dynamic> params;
  final AlertSeverity severity;

  const ToastShowed(
    this.message, {
    this.params = const [],
    this.severity = AlertSeverity.info,
  });
}
