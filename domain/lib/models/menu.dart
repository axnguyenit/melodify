import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

class Menu {
  final List<MenuItem> items;

  Menu({required this.items});

  factory Menu.fromJson(Map<String, dynamic> json) {
    try {
      final renderer = getValue(json, ['menuRenderer']);
      final items = getValue<List>(renderer, ['items']);

      return Menu(
        items: List.from(items.map((e) {
          return MenuItem.fromJson(e);
        })),
      );
    } catch (e) {
      log.error('Parse Menu Error --> $e');
      rethrow;
    }
  }
}
