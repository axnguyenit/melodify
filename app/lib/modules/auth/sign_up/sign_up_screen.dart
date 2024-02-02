import 'package:core/core.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:melodify/modules/routes.dart';
import 'package:melodify/utils/utils.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseScreenWithBloc<SignUpScreen, SignUpBloc> {
  final _formKey = GlobalKey<FormState>();
  final _phoneTextController = TextEditingController(text: '337965468');
  Country _country = AppConstants.defaultCountry;

  void _pickCountryCode() {
    showCountryPickerDrawer(
      context,
      onSelected: _selectCountry,
    );
  }

  void _selectCountry(Country country) {
    log.logMap(country.toJson());
    setState(() {
      _country = country;
    });
  }

  @override
  void dispose() {
    _phoneTextController.dispose();

    super.dispose();
  }

  void _signUp() {
    bloc.add(
      SignUpSubmitted(
        phoneNumber: '+${_country.phoneCode}${_phoneTextController.text}',
      ),
    );
  }

  @override
  Widget buildListeners(Widget child) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (_, state) {
        if (state is SignUpSubmitSuccess) {
          router.pushNamed(
            Routes.smsVerification,
            arguments: {
              'phone': '+${_country.phoneCode}${_phoneTextController.text}',
              'verificationId': state.verificationId,
            },
          );
        }

        if (state is SignUpSubmitFailure) {
          if (state.error.isInvalidPhoneNumber) {
            showWarningMessage(Strings.invalidPhoneNumber);
          }
          if (state.error.isPhoneAlreadyExists) {
            showWarningMessage(Strings.phoneNumberAlreadyExists);
          }
        }
      },
      child: child,
    );
  }

  @override
  PreferredSizeWidget get buildAppBar {
    return AppBar(
      title: Text(
        context.translate(
          Strings.signUp,
        ),
      ),
    );
  }

  @override
  Widget get buildBody {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      child: XForm(
        formKey: _formKey,
        onSubmitted: _signUp,
        builder: (context, autoValidateMode, onSubmitted) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
                PhoneField(
                  label: context.translate(Strings.phone),
                  placeholder: '1234567',
                  controller: _phoneTextController,
                  phoneCode: _country.phoneCode,
                  onPhoneCodePressed: _pickCountryCode,
                  autoValidateMode: autoValidateMode,
                  validationRules: [
                    ValidationRule<String>.required(
                      context.translate(Strings.phoneIsRequired),
                    ),
                    ValidationRule<String>.phone(
                      context.translate(Strings.invalidPhoneNumberFormat),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.translate(
                        Strings.alreadyHaveAccount,
                      ),
                      style: context.bodySmall,
                    ),
                    const SizedBox(width: 4),
                    XLinkButton(
                      onPressed: router.pop,
                      title: context.translate(
                        Strings.signIn,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (_, state) {
                    return XButton(
                      loading: state is SignUpSubmitInProgress,
                      title: context.translate(
                        Strings.signUp,
                      ),
                      onPressed: onSubmitted,
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
