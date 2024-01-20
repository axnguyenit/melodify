import 'package:flutter/material.dart';
import 'package:melodify/widgets/widgets.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: XText.headlineMedium('PAGE NOT FOUND'),
      ),
    );
  }
}
