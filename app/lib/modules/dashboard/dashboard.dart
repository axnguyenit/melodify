import 'package:audio_service/audio_service.dart';
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

import 'media_duration.dart';
import 'media_player.dart';
import 'media_player_controller.dart';

part 'bottom_bar_item.dart';

class DashboardScreen extends StatefulWidget {
  final int selectedIndex;

  const DashboardScreen({super.key, this.selectedIndex = 0});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends BaseScreen<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  Future<void> _initializeAnimation() async {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );

    final offsetTween = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 1.0),
    );

    _offsetAnimation = offsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
        reverseCurve: Curves.linear,
      ),
    );
  }

  @override
  Widget? get buildBottomNavigationBar {
    return StreamBuilder<MediaItem?>(
      stream: di.get<AppAudioHandler>().mediaItem,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SizedBox.shrink();
        }

        return AnimatedBuilder(
          animation: MediaPlayerController(),
          builder: (_, __) {
            final isMini = MediaPlayerController().isMini(context);

            if (isMini) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isMini && snapshot.data != null) ...[
                  MediaDuration(
                    maxDuration: snapshot.data!.duration?.inSeconds.toDouble(),
                  )
                ],
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  // child: BottomNavigationBar(
                  //   items: BottomBar.values.map((e) {
                  //     return e.toNavigationBarItem(context);
                  //   }).toList(),
                  //   currentIndex: _selectedIndex,
                  //   onTap: _onTabChanged,
                  // ),
                  child: !isMini
                      ? const SizedBox.shrink()
                      : BottomNavigationBar(
                          items: BottomBar.values.map((e) {
                            return e.toNavigationBarItem(context);
                          }).toList(),
                          currentIndex: _selectedIndex,
                          onTap: _onTabChanged,
                        ),
                  transitionBuilder: (child, _) {
                    return SlideTransition(
                      position: _offsetAnimation,
                      child: child,
                    );
                  },
                ),
                // AnimatedSlide(
                //   offset:
                //       isMini ? const Offset(0.0, 0.0) : const Offset(0.0, 1.0),
                //   duration: const Duration(milliseconds: 300),
                //   child: BottomNavigationBar(
                //     items: BottomBar.values.map((e) {
                //       return e.toNavigationBarItem(context);
                //     }).toList(),
                //     currentIndex: _selectedIndex,
                //     onTap: _onTabChanged,
                //   ),
                // ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget get buildBody {
    return Stack(
      children: [
        IndexedStack(
          index: _selectedIndex,
          children: const [
            HomeScreen(),
            ExploreScreen(),
            LibraryScreen(),
          ],
        ),
        const MediaPlayer(),
      ],
    );
  }
}
