import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:melodify/modules/common/common.dart';
import 'package:melodify/modules/routes.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

class SmsVerificationScreen extends StatefulWidget {
  final String phone;
  final String verificationId;

  const SmsVerificationScreen({
    super.key,
    required this.phone,
    required this.verificationId,
  });

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState
    extends BaseScreenWithBloc<SmsVerificationScreen, SmsVerificationBloc> {
  final _smsVerificationController = SMSVerificationController();
  final _otpTextController = TextEditingController();
  String? _otpErrorMessage;
  late String _verificationId;

  @override
  void initState() {
    super.initState();

    _verificationId = widget.verificationId;
  }

  @override
  void dispose() {
    _otpTextController.dispose();

    super.dispose();
  }

  void _resendOtp() {
    bloc.add(
      SmsVerificationResent(
        phone: widget.phone,
      ),
    );
  }

  void _verifySMS(String otp) {
    if (otp.length < 6) {
      return setState(() {
        _otpErrorMessage = context.translate(
          Strings.invalidVerificationCode,
        );
      });
    }
    bloc.add(
      SmsVerificationVerified(
        phone: widget.phone,
        smsCode: otp,
        verificationId: _verificationId,
      ),
    );
  }

  @override
  Widget buildListeners(Widget child) {
    return BlocListener<SmsVerificationBloc, SmsVerificationState>(
      listener: (_, state) {
        if (state is SmsVerificationVerifyFailure) {
          setState(() {
            _otpErrorMessage = context.translate(
              Strings.invalidVerificationCode,
            );
          });
        }
        if (state is SmsVerificationVerifySuccess) {
          router.pushReplacementNamed(Routes.profileCreation, arguments: {
            'phone': widget.phone,
          });
        }
        if (state is SmsVerificationResendSuccess) {
          _verificationId = state.verificationId;
          _smsVerificationController.sendSMSSuccess();
          setState(() {
            _otpTextController.clear();
            _otpErrorMessage = null;
          });
        }
      },
      child: child,
    );
  }

  @override
  PreferredSizeWidget? get buildAppBar {
    return AppBar(
      title: XText.titleLarge(
        context.translate(Strings.smsVerification),
      ),
    );
  }

  @override
  Widget get buildBody {
    return SingleChildScrollView(
      padding: EdgeInsets.all(horizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<SmsVerificationBloc, SmsVerificationState>(
            builder: (_, state) {
              final loading = state is SmsVerificationVerifyInProgress ||
                  state is SmsVerificationVerifySuccess;

              return SMSVerification(
                loading: loading,
                controller: _smsVerificationController,
                textController: _otpTextController,
                errorMessage: _otpErrorMessage,
                width:
                    AppConstants.screenSize.width - AppConstants.appPadding * 2,
                onCompleted: _verifySMS,
                onResendSubmitted: _resendOtp,
                onChanged: (_) {
                  setState(() {
                    _otpErrorMessage = null;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
