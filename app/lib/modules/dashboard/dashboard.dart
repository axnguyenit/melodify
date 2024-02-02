import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:melodify/modules/home/home_screen.dart';
import 'package:melodify/modules/library/library_screen.dart';
import 'package:melodify/modules/settings/settings_screen.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

part 'bottom_bar_item.dart';

class DashboardScreen extends StatefulWidget {
  final int selectedIndex;

  const DashboardScreen({super.key, this.selectedIndex = 0});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends BaseScreen<DashboardScreen> {
  late int _selectedIndex;

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget? get buildBottomNavigationBar {
    return BottomNavigationBar(
      items: BottomBar.values.map((e) {
        return e.toNavigationBarItem(context);
      }).toList(),
      currentIndex: _selectedIndex,
      onTap: _onTabChanged,
    );
  }

  @override
  Widget get buildBody {
    return IndexedStack(
      index: _selectedIndex,
      children: const [
        HomeScreen(),
        LibraryScreen(),
        SettingsScreen(),
      ],
    );
  }
}
