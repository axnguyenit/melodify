import 'package:flutter/material.dart';

typedef XFormBuilder = Widget Function(
  BuildContext context,
  AutovalidateMode? autoValidateMode,
  VoidCallback onSubmitted,
);

class XForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmitted;
  final XFormBuilder builder;

  const XForm({
    super.key,
    required this.formKey,
    required this.onSubmitted,
    required this.builder,
  });

  @override
  State<XForm> createState() => _XFormState();
}

class _XFormState extends State<XForm> {
  AutovalidateMode? _autoValidateMode;

  void _formSubmitted() {
    if (widget.formKey.currentState!.validate()) return widget.onSubmitted();

    setState(() {
      _autoValidateMode = AutovalidateMode.onUserInteraction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: widget.builder(context, _autoValidateMode, _formSubmitted),
    );
  }
}
