import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';

class MediaDuration extends StatelessWidget {
  final double _maxDuration;

  const MediaDuration({super.key, double? maxDuration})
      : _maxDuration = maxDuration ?? 240.0;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: context.textColor,
        inactiveTrackColor: context.disabledBackgroundColor,
        trackHeight: 1,
        thumbColor: context.textColor,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
        trackShape: const RectangularSliderTrackShape(),
      ),
      child: StreamBuilder<Duration>(
        stream: AudioService.position,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox.shrink();

          final duration = snapshot.data!;
          final durationInSeconds = duration.inSeconds.toDouble();

          if (durationInSeconds < 0.0 || (durationInSeconds > _maxDuration)) {
            return const SizedBox.shrink();
          }

          return Slider(
            value: durationInSeconds,
            max: _maxDuration,
            onChanged: (newPosition) {
              di
                  .get<AppAudioHandler>()
                  .seek(Duration(seconds: newPosition.round()));
            },
          );
        },
      ),
    );
  }
}
