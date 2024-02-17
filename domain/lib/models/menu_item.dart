import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

class MenuItem {
  final String title;
  final MenuItemType type;
  final IconType iconType;

  MenuItem({
    required this.title,
    required this.type,
    required this.iconType,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    try {
      Map<String, dynamic> renderer = {};
      MenuItemType type = MenuItemType.service;
      IconType? iconType;
      String? title;
      if (json.containsKey('menuNavigationItemRenderer')) {
        renderer = getValue(json, ['menuNavigationItemRenderer']);
        type = MenuItemType.navigation;
      } else if (json.containsKey('toggleMenuServiceItemRenderer')) {
        renderer = getValue(json, ['toggleMenuServiceItemRenderer']);
        title = getRunsText(renderer, key: 'defaultText');
        iconType =
            IconType.fromValue(getValue(renderer, ['defaultIcon', 'iconType']));
      } else {
        renderer = getValue(json, ['menuServiceItemRenderer']);
      }

      title ??= getRunsText(renderer);
      iconType ??= IconType.fromValue(getValue(renderer, ['icon', 'iconType']));
      return MenuItem(
        title: title,
        type: type,
        iconType: iconType,
      );
    } catch (e) {
      log
        ..logMap(json)
        ..error('Parse MenuItem Error --> $e');
      rethrow;
    }
  }
}
