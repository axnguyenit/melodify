import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:melodify/widgets/widgets.dart';

import '../storybook.dart';

// final _emailTextController = TextEditingController();
// final _passwordTextController = TextEditingController();

final List<String> _genders = <String>['Male', 'Female', 'Other'];
// final _controller = FormController(
//   defaultValues: {
//     'email': 'axnguyen.it@gmail.com',
//     'gender': _genders.first,
//   },
//   onSubmitted: (Map<String, dynamic> values) async {
//     log.info('values ──> ${values.toString()}');
//   },
//   validationRules: {
//     'email': Validation(
//       controller: _emailTextController,
//       rules: [
//         ValidationRule<String>.required('Email is required'),
//         ValidationRule<String>.email('Email format is invalid'),
//       ],
//     ),
//     'password': Validation(
//       controller: _passwordTextController,
//       rules: [
//         ValidationRule<String>.required('Password is required'),
//         ValidationRule<String>.min(8,
//           'Password must be at least 8 characters'
//         )
//       ],
//     ),
//     'gender': Validation(
//       rules: [
//         ValidationRule<String>.required('Gender is required'),
//       ],
//     ),
//   },
// );

// ────────────────────────────────────────────

// ignore: must_be_immutable
class FormValidationStory extends Story {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController(
    text: 'axnguyen.it@gmail.com',
  );
  final _passwordTextController = TextEditingController();

  // final _genderTextController = TextEditingController(text: _genders.first);
  String? _selectedGender;

  FormValidationStory({super.key});

  @override
  WidgetMap storyContent() {
    Function? renderFunction;

    return WidgetMap(
      title: 'Form Validation',
      builder: (context) {
        return StatefulStory(
          builder: () {
            return XForm(
              formKey: _formKey,
              onSubmitted: () {
                log.info('values: ', messages: [
                  'email: ${_emailTextController.text}',
                  'password: ${_passwordTextController.text}',
                  'gender: $_selectedGender',
                ]);
              },
              builder: (context, autoValidateMode, onSubmitted) {
                return SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      XTextField(
                        label: 'Email',
                        placeholder: 'Enter email',
                        controller: _emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: print,
                        autoValidateMode: autoValidateMode,
                        validationRules: [
                          ValidationRule<String>.required('Email is required'),
                          ValidationRule<String>.email(
                              'Email format is invalid'),
                        ],
                      ),
                      spacer,
                      PasswordField(
                        label: 'Password',
                        placeholder: 'Enter password',
                        controller: _passwordTextController,
                        onFieldSubmitted: print,
                        autoValidateMode: autoValidateMode,
                        validationRules: [
                          ValidationRule<String>.required(
                            'Password is required',
                          ),
                          ValidationRule<String>.min(
                            6,
                            'Password must be at least 6 characters',
                          )
                        ],
                      ),
                      spacer,
                      ZDropdown<String>(
                        label: 'Gender',
                        items: _genders,
                        required: true,
                        selectedValue: _selectedGender,
                        errorMessage: 'Gender is required',
                        autovalidateMode: autoValidateMode,
                        onChanged: (value) {
                          _selectedGender = value;
                          renderFunction!();
                        },
                        itemBuilder: (context, item) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(item),
                          );
                        },
                      ),
                      // spacer,
                      // DropdownButtonFormField<String>(
                      //   decoration: const InputDecoration(
                      //     labelText: 'Gender',
                      //   ),
                      //   autovalidateMode: autoValidateMode,
                      //   value: _selectedGender,
                      //   items: _genders
                      //       .map<DropdownMenuItem<String>>(
                      //           (e) => DropdownMenuItem<String>(
                      //                 value: e,
                      //                 child: XText(e),
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
                      //     renderFunction!();
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
                      spacer,
                      XButton(
                        title: 'Fill',
                        onPressed: () {
                          _emailTextController.text = 'axnguyen.it@gmail.com';
                          _passwordTextController.text = 'P@ssw0rd';
                          _selectedGender = _genders.first;
                          renderFunction!();
                        },
                      ),
                      spacer,
                      XButton(
                        title: 'Submit',
                        onPressed: onSubmitted,
                      ),
                      spacer,
                      XButton(
                        title: 'Clear',
                        onPressed: () {
                          _emailTextController.text = '';
                          _passwordTextController.text = '';
                          _selectedGender = null;
                          renderFunction!();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          renderFunction: (render) {
            renderFunction = render;
          },
        );
      },
    );
  }
}
