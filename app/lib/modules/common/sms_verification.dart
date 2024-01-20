import 'dart:async';

import 'package:melodify/constants/constants.dart';
import 'package:melodify/modules/mixins/mixins.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:resources/resources.dart';

class SMSVerificationController {
  VoidCallback? _onSMSResentSuccess;
  VoidCallback? _onStopCountdown;

  set onSMSResentSuccess(VoidCallback onSMSResentSuccess) {
    _onSMSResentSuccess = onSMSResentSuccess;
  }

  void sendSMSSuccess() {
    _onSMSResentSuccess?.call();
  }

  set onStopCountdown(VoidCallback onStopCountdown) {
    _onStopCountdown = onStopCountdown;
  }

  void stopCountdown() {
    _onStopCountdown?.call();
  }
}

class SMSVerification extends StatefulWidget {
  final VoidCallback onResendSubmitted;
  final SMSVerificationController controller;
  final String? errorMessage;
  final FocusNode? focusNode;
  final int length;
  final double width;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool loading;
  final TextEditingController? textController;

  const SMSVerification({
    super.key,
    required this.onResendSubmitted,
    required this.controller,
    this.errorMessage,
    this.focusNode,
    this.length = 6,
    required this.width,
    this.onCompleted,
    this.onChanged,
    this.onSubmitted,
    this.loading = false,
    this.textController,
  });

  @override
  State<SMSVerification> createState() => _SMSVerificationState();
}

class _SMSVerificationState extends State<SMSVerification> with StateMixin {
  late Timer _timer;
  late ValueNotifier<int> _countDownNotifier;

  void _tartCountDownTimer({int duration = AppConstants.smsCountDownTime}) {
    _countDownNotifier.value = duration;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_countDownNotifier.value <= 0) return _timer.cancel();

      _countDownNotifier.value -= 1;
    });
  }

  void _stopCountDownTimer() {
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    _countDownNotifier = ValueNotifier(-1);
    widget.controller
      ..onSMSResentSuccess = _tartCountDownTimer
      ..onStopCountdown = _stopCountDownTimer;

    postFrame(_tartCountDownTimer);
  }

  @override
  void dispose() {
    _timer.cancel();
    _countDownNotifier.dispose();

    super.dispose();
  }

  PinTheme pinTheme(InputBorder inputBorder) {
    return PinTheme(
      textStyle: context.bodyLarge,
      height: AppConstants.formFieldHeight,
      width: AppConstants.formFieldHeight,
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          inputBorder.borderSide,
        ),
        borderRadius: BorderRadius.circular(
          AppConstants.formFieldBorderRadius,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const boxSize = AppConstants.formFieldHeight;
    final spacing =
        (widget.width - (boxSize * widget.length)) / (widget.length - 1);

    return Column(
      children: [
        Pinput(
          length: widget.length,
          autofocus: true,
          controller: widget.textController,
          separatorBuilder: (_) => SizedBox(width: spacing),
          listenForMultipleSmsOnAndroid: true,
          errorText: widget.errorMessage?.trim(),
          forceErrorState: widget.errorMessage.isNotNullOrEmpty,
          errorTextStyle: context.bodySmall
              ?.copyWith(height: 0.3, color: context.errorColor),
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          onCompleted: widget.onCompleted,
          defaultPinTheme: pinTheme(
            context.inputDecorationTheme.enabledBorder!,
          ),
          focusedPinTheme: pinTheme(
            context.inputDecorationTheme.focusedBorder!,
          ),
          errorPinTheme: pinTheme(
            context.inputDecorationTheme.errorBorder!,
          ),
        ),
        const SizedBox(height: 24),
        AnimatedBuilder(
          animation: _countDownNotifier,
          builder: (_, __) {
            if (_countDownNotifier.value > 0) {
              return XText.bodySmall(
                context.translate(
                  Strings.resendInXSeconds,
                  params: [_countDownNotifier.value],
                ),
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                XText.bodySmall(
                  context.translate(
                    Strings.doNotReceiveCode,
                  ),
                ),
                const SizedBox(width: 4),
                XLinkButton(
                  title: context.translate(Strings.resend),
                  color: context.primaryColor,
                  onPressed: widget.onResendSubmitted,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
