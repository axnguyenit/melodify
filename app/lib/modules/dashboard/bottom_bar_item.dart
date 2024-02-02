part of 'dashboard.dart';

enum BottomBar {
  home,
  library,
  settings;

  String get _iconPath {
    return switch (this) {
      BottomBar.home => AppIcons.albumFill,
      BottomBar.library => AppIcons.mvFill,
      BottomBar.settings => AppIcons.listSettingsFill,
    };
  }

  String get title {
    return switch (this) {
      BottomBar.home => Strings.home,
      BottomBar.library => Strings.library,
      BottomBar.settings => Strings.settings,
    };
  }

  BottomNavigationBarItem toNavigationBarItem(BuildContext context) {
    return BottomNavigationBarItem(
      icon: AppIcon(
        assetName: _iconPath,
        color: context.iconColor,
        width: 20,
        height: 20,
      ),
      activeIcon: AppIcon(
        assetName: _iconPath,
        color: context.textColor,
        width: 20,
        height: 20,
      ),
      label: context.translate(title),
    );
  }
}
