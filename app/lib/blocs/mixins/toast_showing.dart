import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/widgets/widgets.dart';

mixin ToastShowing {
  ToastBloc get _toastShowing => di.get<ToastBloc>();

  void showInfoMessage(String message, {List<dynamic> params = const []}) {
    _toastShowing.add(
      ToastShowed(
        message,
        params: params,
        severity: AlertSeverity.info,
      ),
    );
  }

  void showSuccessMessage(String message, {List<dynamic> params = const []}) {
    _toastShowing.add(
      ToastShowed(
        message,
        params: params,
        severity: AlertSeverity.success,
      ),
    );
  }

  void showWarningMessage(String message, {List<dynamic> params = const []}) {
    _toastShowing.add(
      ToastShowed(
        message,
        params: params,
        severity: AlertSeverity.warning,
      ),
    );
  }

  void showErrorMessage(String message, {List<dynamic> params = const []}) {
    _toastShowing.add(
      ToastShowed(
        message,
        params: params,
        severity: AlertSeverity.error,
      ),
    );
  }
}
