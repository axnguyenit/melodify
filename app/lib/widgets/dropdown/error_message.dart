import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

// Display the helper and error text. When the error text appears
// it fades and the helper text fades out. The error text also
// slides upwards a little when it first appears.
class ErrorMessage extends StatefulWidget {
  final String? message;
  final Duration duration;

  const ErrorMessage({
    super.key,
    required this.message,
    required this.duration,
  });

  @override
  State<ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<ErrorMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool get _hasError => widget.message != null;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    if (_hasError) {
      _controller.value = 1.0;
    }
    _controller.addListener(_handleChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleChange() {
    setState(() {
      // The _controller's value has changed.
    });
  }

  @override
  void didUpdateWidget(ErrorMessage oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newMessage = widget.message;
    final oldMessage = oldWidget.message;
    final messageStateChanged = (newMessage != null) != (oldMessage != null);
    final helperTextStateChanged = newMessage == null;

    if (messageStateChanged || helperTextStateChanged) {
      if (newMessage != null) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // If the height of this widget and the counter are zero ("empty") at
    // layout time, no space is allocated for the subtext.
    if (!_hasError) return const SizedBox.shrink();

    return Semantics(
      container: true,
      child: FadeTransition(
        opacity: _controller,
        child: FractionalTranslation(
          translation: Tween<Offset>(
            begin: const Offset(0.0, -0.25),
            end: Offset.zero,
          ).evaluate(_controller.view),
          child: Padding(
            padding: EdgeInsets.only(
              top: 8.0,
              left: AppConstants.inputContentPadding.left,
            ),
            child: HelperText(
              message: widget.message!,
              status: HelperTextStatus.negative,
              style: context.inputDecorationTheme.errorStyle,
            ),
          ),
        ),
      ),
    );
  }
}
