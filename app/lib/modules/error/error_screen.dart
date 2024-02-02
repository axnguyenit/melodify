import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'PAGE NOT FOUND',
          style: context.headlineMedium,
        ),
      ),
    );
  }
}
