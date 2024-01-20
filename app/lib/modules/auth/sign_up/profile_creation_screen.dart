import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

class ProfileCreationScreen extends StatefulWidget {
  final String phone;

  const ProfileCreationScreen({
    super.key,
    required this.phone,
  });

  @override
  State<ProfileCreationScreen> createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState
    extends BaseScreenWithBloc<ProfileCreationScreen, ProfileCreationBloc> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailTextController;
  late final TextEditingController _phoneTextController;
  late final TextEditingController _firstNameTextController;
  late final TextEditingController _lastNameTextController;
  late final TextEditingController _passwordTextController;
  late final TextEditingController _confirmPasswordTextController;

  void _createProfile() {
    bloc.add(
      ProfileCreationSubmitted(
        email: _emailTextController.text.toLowerCase(),
        phone: widget.phone,
        firstName: _firstNameTextController.text,
        lastName: _lastNameTextController.text,
        password: _passwordTextController.text,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _emailTextController = TextEditingController();
    _phoneTextController = TextEditingController(text: widget.phone);
    _firstNameTextController = TextEditingController();
    _lastNameTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _phoneTextController.dispose();
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();

    super.dispose();
  }

  @override
  PreferredSizeWidget get buildAppBar {
    return AppBar(
      title: XText.titleMedium(
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
        onSubmitted: _createProfile,
        builder: (context, autoValidateMode, onSubmitted) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
                XTextField(
                  readOnly: true,
                  label: context.translate(Strings.phone),
                  controller: _phoneTextController,
                ),
                const SizedBox(height: 24),
                XTextField(
                  label: context.translate(Strings.emailLabel),
                  placeholder: context.translate(Strings.emailLabel),
                  controller: _emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  autoValidateMode: autoValidateMode,
                  validationRules: [
                    ValidationRule<String>.required(
                      context.translate(Strings.emailIsRequired),
                    ),
                    ValidationRule<String>.email(
                      context.translate(Strings.emailFormatIsInvalid),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                XTextField(
                  label: 'First name',
                  placeholder: 'First name',
                  controller: _firstNameTextController,
                  keyboardType: TextInputType.emailAddress,
                  autoValidateMode: autoValidateMode,
                  validationRules: [
                    ValidationRule<String>.required(
                      context.translate(Strings.emailIsRequired),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                XTextField(
                  label: 'Last name',
                  placeholder: 'Last name',
                  controller: _lastNameTextController,
                  keyboardType: TextInputType.streetAddress,
                  autoValidateMode: autoValidateMode,
                  validationRules: [
                    ValidationRule<String>.required(
                      context.translate(Strings.emailIsRequired),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                PasswordField(
                  label: 'Password',
                  placeholder: 'password',
                  controller: _passwordTextController,
                  onFieldSubmitted: print,
                  autoValidateMode: autoValidateMode,
                  validationRules: [
                    ValidationRule<String>.required(
                      context.translate(Strings.passwordIsRequired),
                    ),
                    ValidationRule<String>.min(
                      AppConstants.minLengthOfPassword,
                      context.translate(
                        Strings.passwordLengthIsInvalid,
                        params: [AppConstants.minLengthOfPassword],
                      ),
                    ),
                    ValidationRule<String>.password(
                      context.translate(
                        Strings.passwordLengthIsInvalid,
                        params: [AppConstants.minLengthOfPassword],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                PasswordField(
                  label: 'Confirm Password',
                  placeholder: 'Confirm password',
                  controller: _confirmPasswordTextController,
                  onFieldSubmitted: print,
                  autoValidateMode: autoValidateMode,
                  validationRules: [
                    ValidationRule<String>.required(
                      context.translate(Strings.passwordIsRequired),
                    ),
                    ValidationRule<String>.min(
                      AppConstants.minLengthOfPassword,
                      context.translate(
                        Strings.passwordLengthIsInvalid,
                        params: [AppConstants.minLengthOfPassword],
                      ),
                    ),
                    ValidationRule(
                      message: 'Confirm password does not match',
                      validate: (value) {
                        return value == _passwordTextController.text;
                      },
                    )
                  ],
                ),
                const SizedBox(height: 24),
                BlocBuilder<ProfileCreationBloc, ProfileCreationState>(
                  builder: (_, state) {
                    return XButton(
                      loading: state is ProfileCreationSubmitInProgress,
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
