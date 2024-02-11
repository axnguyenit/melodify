import 'package:domain/domain.dart';

class YTMSearchSection {
  final String title;
  final List<YTMSectionItem> items;

  YTMSearchSection({
    required this.title,
    required this.items,
  });

  factory YTMSearchSection.fromJson(Map<String, dynamic> json) {
    return YTMSearchSection(
      title: json['title'],
      items: ((json['items'] ?? []) as List).map((content) {
        return YTMSectionItem.fromJson(content);
      }).toList(),
    );
  }
}
