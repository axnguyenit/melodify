part of 'dashboard.dart';

enum BottomBar {
  home,
  explore,
  library;

  String get _iconPath {
    return switch (this) {
      BottomBar.home => AppIcons.homeOutline,
      BottomBar.explore => AppIcons.exploreOutline,
      BottomBar.library => AppIcons.libraryOutline,
    };
  }

  String get _activeIconPath {
    return switch (this) {
      BottomBar.home => AppIcons.homeFill,
      BottomBar.explore => AppIcons.exploreFill,
      BottomBar.library => AppIcons.libraryFill,
    };
  }

  String get title {
    return switch (this) {
      BottomBar.home => Strings.home,
      BottomBar.explore => Strings.explore,
      BottomBar.library => Strings.library,
    };
  }

  BottomNavigationBarItem toNavigationBarItem(BuildContext context) {
    return BottomNavigationBarItem(
      icon: AppIcon(
        assetName: _iconPath,
        color: context.textColor,
        width: 24,
        height: 24,
      ),
      activeIcon: AppIcon(
        assetName: _activeIconPath,
        color: context.textColor,
        width: 24,
        height: 24,
      ),
      label: context.translate(title),
    );
  }
}
