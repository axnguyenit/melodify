import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:melodify/modules/routes.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class SignInValues {}

class _SignInScreenState extends BaseScreenWithBloc<SignInScreen, SignInBloc> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController(
    text: 'axnguyen.it@gmail.com',
  );
  final _passwordTextController = TextEditingController();

  // String? _selectedGender;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();

    super.dispose();
  }

  Future<void> _signInSubmitted() async {
    bloc.add(SignInSubmitted(
      email: _emailTextController.text,
      password: _passwordTextController.text,
    ));
  }

  @override
  PreferredSizeWidget get buildAppBar {
    return AppBar(
      title: Text(
        context.translate(
          Strings.signIn,
        ),
      ),
    );
  }

  @override
  Widget buildListeners(Widget child) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (_, state) {
        if (state is SignInSubmitFailure) {
          if (state.error.isInvalidPassword) {
            showWarningMessage(Strings.passwordIsIncorrect);
          }

          if (state.error.isUserNotFound) {
            showWarningMessage(Strings.emailNotFound);
          }

          if (state.error.isTooManyRequest) {
            showWarningMessage(
              Strings.tooManyRequestMessage,
              params: [
                context.translate(
                  Strings.xMinutes,
                  params: [10],
                )
              ],
            );
          }
        }
      },
      child: child,
    );
  }

  @override
  Widget get buildBody {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.appPadding,
      ),
      child: XForm(
        formKey: _formKey,
        onSubmitted: _signInSubmitted,
        builder: (context, autoValidateMode, onSubmitted) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
                XTextField(
                  label: 'Email',
                  placeholder: 'Enter email',
                  controller: _emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: print,
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
                PasswordField(
                  label: 'Password',
                  placeholder: 'Enter password',
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
                  ],
                ),
                // const SizedBox(height: 24),
                // ZDropdown<String>(
                //   items: const ['Male', 'Female', 'Other'],
                //   selectedValue: _selectedGender,
                //   // label: 'Select gender',
                //   label: 'Password',
                //   placeholder: 'Select gender',
                //   errorMessage: 'Gender is required',
                //   onChanged: (value) {
                //     setState(() {
                //       _selectedGender = value;
                //     });
                //   },
                //   itemBuilder: (context, item) {
                //     return Align(
                //       alignment: Alignment.centerLeft,
                //       child: XText(
                //         item,
                //         maxLines: 1,
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     );
                //   },
                // ),
                // const SizedBox(height: 24),
                // DropdownButtonFormField<String>(
                //   decoration: const InputDecoration(
                //     labelText: 'Password',
                //     hintText: 'Select gender',
                //     // contentPadding: EdgeInsets.fromLTRB(16, 12, 8, 12),
                //     floatingLabelBehavior: FloatingLabelBehavior.always,
                //   ),
                //   isExpanded: true,
                //   autovalidateMode: autoValidateMode,
                //   value: _selectedGender,
                //   icon: Icon(Icons.keyboard_arrow_down_rounded),
                //   // dropdownColor: Colors.red,
                //   isDense: true,
                //   alignment: Alignment.centerLeft,
                //   padding: EdgeInsets.zero,
                //   selectedItemBuilder: (context) {
                //     return ['Male', 'Female', 'Other']
                //         .map<DropdownMenuItem<String>>(
                //             (e) => DropdownMenuItem<String>(
                //                   value: e,
                //                   child: XText(
                //                     e,
                //                   ),
                //                   // label: e,
                //                   // labelWidget: XText(e),
                //                   // value: e,
                //                   // style: ButtonStyle(
                //                   //   padding: MaterialStateProperty.all<
                //                   //       EdgeInsetsGeometry>(
                //                   //     const EdgeInsets.only(left: 8.0),
                //                   //   ),
                //                   // ),
                //                 ))
                //         .toList();
                //   },
                //   items: ['Male', 'Female', 'Other']
                //       .map<DropdownMenuItem<String>>(
                //           (e) => DropdownMenuItem<String>(
                //                 value: e,
                //                 child: XStatus(
                //                   status: XStatusType.positive,
                //                   label: e,
                //                 ),
                //                 // label: e,
                //                 // labelWidget: XText(e),
                //                 // value: e,
                //                 // style: ButtonStyle(
                //                 //   padding: MaterialStateProperty.all<
                //                 //       EdgeInsetsGeometry>(
                //                 //     const EdgeInsets.only(left: 8.0),
                //                 //   ),
                //                 // ),
                //               ))
                //       .toList(),
                //   onChanged: (value) {
                //     _selectedGender = value;
                //   },
                //   validator: (value) {
                //     final rules = [
                //       ValidationRule<String>.required(
                //         'Gender is required',
                //       ),
                //     ];

                //     return rules.validate(value);
                //   },
                // ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.translate(
                        Strings.doNotHaveAccount,
                      ),
                      style: context.bodySmall,
                    ),
                    const SizedBox(width: 4),
                    XLinkButton(
                      onPressed: () {
                        router.pushNamed(Routes.signUp);
                      },
                      title: context.translate(
                        Strings.signUp,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                XButton(
                  title: context.translate(Strings.signIn),
                  onPressed: onSubmitted,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
