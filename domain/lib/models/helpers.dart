typedef JsonMap = Map<String, dynamic>;

T getValue<T>(dynamic map, List keys, [T? fallback]) {
  dynamic temp = map;
  for (final key in keys) {
    temp = temp[key];
    if (temp == null) break;
  }
  return (temp ?? fallback) as T;
}

/// Input:
///   {
///     "text": {
///       "runs": [
///         {
///           "text": "Song"
///         },
///         {
///           "text": " • "
///         },
///         {
///           "text": "04:11"
///         },
///       ]
///     }
///   }
///
/// Output: Song • 04:11
String getRunsText(Map<String, dynamic> json, {String key = 'text'}) {
  final runs = getValue<List>(json, [key, 'runs'], []);

  return runs.map((e) => e['text'].toString()).join();
}
