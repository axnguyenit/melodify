import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';

class XLoading extends StatelessWidget {
  const XLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Container(
        color: Colors.black.withOpacity(.2),
        alignment: Alignment.center,
        child: Container(
          width: 50.0,
          height: 50.0,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: CircularProgressIndicator(
            backgroundColor: context.cardColor,
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }
}
