typedef MapFunction<S, T> = T Function(S source);

T? ifNotNullThen<S, T>(S? source, MapFunction<S, T> mapFunction) {
  if (source != null) {
    return mapFunction(source);
  }

  return null;
}

extension MapExtensions on Map? {
  /// Returns `true` if this nullable char sequence is `null`.
  bool get isNull => this == null;

  /// Returns `false` if this nullable char sequence is `null`.
  bool get isNotNull => this != null;
}
