import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/context_extension.dart';

extension AudioServiceRepeatModeExtension on AudioServiceRepeatMode {
  AudioServiceRepeatMode get nextRepeatMode {
    return switch (this) {
      AudioServiceRepeatMode.none => AudioServiceRepeatMode.all,
      AudioServiceRepeatMode.one => AudioServiceRepeatMode.none,
      AudioServiceRepeatMode.all => AudioServiceRepeatMode.one,
      _ => AudioServiceRepeatMode.none,
    };
  }

  Widget icon(BuildContext context) {
    return switch (this) {
      AudioServiceRepeatMode.none =>
        Icon(Icons.repeat, color: context.iconColor),
      AudioServiceRepeatMode.one =>
        Icon(Icons.repeat_one, color: context.textColor),
      AudioServiceRepeatMode.all =>
        Icon(Icons.repeat, color: context.textColor),
      _ => Icon(Icons.repeat, color: context.iconColor),
    };
  }
}
