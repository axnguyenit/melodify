import 'dart:math';

import 'package:flutter/foundation.dart';

extension NumExtension on num {
  bool get isInteger => this is int || this == roundToDouble();
}

extension StorageExtension on Uint8List {
  String formatBytes({int decimals = 2}) {
    final bytes = buffer.lengthInBytes;
    if (bytes <= 0) {
      return '0 B';
    }
    const suffixes = ['B', 'KB', 'MB', 'GB'];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
