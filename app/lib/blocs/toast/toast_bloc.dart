import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

part 'toast_event.dart';
part 'toast_state.dart';

@LazySingleton()
class ToastBloc extends BaseBloc<ToastEvent, ToastState> {
  ToastBloc() : super(Keys.Blocs.toast, ToastInitial()) {
    on<ToastShowed>(_onToastShowed);
  }

  void _onToastShowed(
    ToastShowed event,
    Emitter<ToastState> emit,
  ) {
    emit(ToastShowSuccess(
      message: event.message,
      severity: event.severity,
      params: event.params,
    ));
  }
}
