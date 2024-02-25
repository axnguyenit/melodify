import 'package:audio_service/audio_service.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/di/di.dart';
import 'package:melodify/global/global.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:melodify/modules/explore/explore_screen.dart';
import 'package:melodify/modules/home/home_screen.dart';
import 'package:melodify/modules/library/library_screen.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

import 'mini_player.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<MediaItem?>(
          stream: di.get<AppAudioHandler>().mediaItem,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              log
                ..error('MINI PLAYER ERROR --> ${snapshot.error}')
                ..error(snapshot.stackTrace);
              return const SizedBox.shrink();
            }
            final mediaItem = snapshot.data;
            if (mediaItem == null) {
              return const SizedBox.shrink();
            } else {
              return MiniPlayer(mediaItem: mediaItem);
            }
          },
        ),
        BottomNavigationBar(
          items: BottomBar.values.map((e) {
            return e.toNavigationBarItem(context);
          }).toList(),
          currentIndex: _selectedIndex,
          onTap: _onTabChanged,
        ),
      ],
    );
  }

  @override
  Widget get buildBody {
    return IndexedStack(
      index: _selectedIndex,
      children: const [
        HomeScreen(),
        ExploreScreen(),
        LibraryScreen(),
      ],
    );
  }
}
