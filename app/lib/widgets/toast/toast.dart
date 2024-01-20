import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

part 'toast_container.dart';
part 'x_safe_area.dart';

typedef ControllerCallback = void Function(AnimationController);

enum DismissType { onTap, onSwipe, none }

OverlayEntry? _previousEntry;

/// Displays a widget that will be passed to [child] parameter above the current
/// contents of the app, with transition animation
///
/// The [child] argument is used to pass widget that you want to show
///
/// The [animationDuration] argument is used to specify duration of
/// enter transition
///
/// The [reverseAnimationDuration] argument is used to specify duration of
/// exit transition
///
/// The [displayDuration] argument is used to specify duration displaying
///
/// The [onTap] callback of [Toast]
///
/// The [overlayState] argument is used to add specific overlay state.
/// If you will not pass it, it will try to get the current overlay state from
/// passed [BuildContext]
///
/// The [persistent] argument is used to make toast persistent, so
/// [displayDuration] will be ignored. Default is false.
///
/// The [onAnimationControllerInit] callback is called on internal
/// [AnimationController] has been initialized.
///
/// The [padding] argument is used to specify amount of outer padding
///
/// [curve] and [reverseCurve] arguments are used to specify curves
/// for in and out animations respectively
///
/// The [safeAreaValues] argument is used to specify the arguments of the
/// [SafeArea] widget that wrap the toast.
///
/// The [dismissType] argument specify which action to trigger to
/// dismiss the toast. Defaults to `ToastDismissType.onTap`
///
/// The [dismissDirection] argument specify in which direction the toast
/// can be dismissed. This argument is only used when [dismissType] is equal
/// to `DismissType.onSwipe`. Defaults to `DismissDirection.up`
Future<void> showToast(
  BuildContext context, {
  Duration animationDuration = const Duration(milliseconds: 800),
  Duration reverseAnimationDuration = const Duration(milliseconds: 800),
  Duration displayDuration = const Duration(milliseconds: 2000),
  VoidCallback? onTap,
  OverlayState? overlayState,
  bool persistent = false,
  ControllerCallback? onAnimationControllerInit,
  EdgeInsets padding = const EdgeInsets.all(16.0),
  Curve curve = Curves.elasticOut,
  Curve reverseCurve = Curves.elasticOut,
  XSafeArea safeAreaValues = const XSafeArea(),
  DismissType dismissType = DismissType.onSwipe,
  DismissDirection dismissDirection = DismissDirection.up,
  required String message,
  Widget? action,
  AlertSeverity severity = AlertSeverity.info,
}) async {
  overlayState ??= Overlay.of(context);
  late final OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) {
      return ToastContainer(
        onDismissed: () {
          if (overlayEntry.mounted && _previousEntry == overlayEntry) {
            overlayEntry.remove();
            _previousEntry = null;
          }
        },
        animationDuration: animationDuration,
        reverseAnimationDuration: reverseAnimationDuration,
        displayDuration: displayDuration,
        onTap: onTap,
        persistent: persistent,
        onAnimationControllerInit: onAnimationControllerInit,
        padding: padding,
        curve: curve,
        reverseCurve: reverseCurve,
        safeAreaValues: safeAreaValues,
        dismissType: dismissType,
        dismissDirection: dismissDirection,
        child: Alert(
          message: message,
          severity: severity,
          action: action,
          isToast: true,
          boxShadow: [
            BoxShadow(
              color: context.shadowColor.withOpacity(0.2),
              offset: const Offset(0.0, 5.0),
              blurRadius: 5.0,
              spreadRadius: -3.0,
            ),
            BoxShadow(
              color: context.shadowColor.withOpacity(0.14),
              offset: const Offset(0.0, 8.0),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: context.shadowColor.withOpacity(0.12),
              offset: const Offset(0.0, 3.0),
              blurRadius: 14.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
      );
    },
  );

  if (_previousEntry != null && _previousEntry!.mounted) {
    _previousEntry?.remove();
  }
  overlayState.insert(overlayEntry);
  _previousEntry = overlayEntry;
}
