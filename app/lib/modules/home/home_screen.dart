import 'dart:math';

import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:melodify/modules/routes.dart';
import 'package:melodify/theme/palette.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreen<HomeScreen> {
  String? _selectedTab;
  final _tabs = [
    'Energise',
    'Mood',
    'Relax',
    'Party',
    'Work out',
    'Commute',
    'Romance',
    'Sad',
    'Focus',
    'Sleep',
  ];

  @override
  Widget get buildBody {
    return SafeArea(
      child: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Text(context.translate(Strings.home)),
              actions: [
                XIconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {
                    router.pushNamed(Routes.search);
                  },
                ),
                XIconButton(
                  icon: const XAvatar(
                    name: 'Luly',
                    size: 28,
                  ),
                  onPressed: () {
                    router.pushNamed(Routes.search);
                  },
                ),
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 36 + horizontalPadding * 2,
                maxHeight: 36 + horizontalPadding * 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.backgroundColor,
                  ),
                  child: ListView.separated(
                    itemCount: _tabs.length,
                    physics: const BouncingScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 12);
                    },
                    itemBuilder: (context, index) {
                      final selected = _tabs[index] == _selectedTab;

                      return ActionChip(
                        label: Text(
                          _tabs[index],
                          style: context.labelLarge?.copyWith(
                            color: selected ? Palette.black : null,
                          ),
                        ),
                        backgroundColor:
                            selected ? context.chipSelectedBackground : null,
                        onPressed: () {
                          setState(() {
                            if (selected) {
                              _selectedTab = null;
                            } else {
                              _selectedTab = _tabs[index];
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: AppConstants.appPadding),
              child: InkWellButton(
                child: Text(
                  'Recently played',
                  style: context.titleMedium,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/recent');
                },
              ),
            ),
            const SizedBox(height: 4),

            Padding(
              padding: const EdgeInsets.only(left: AppConstants.appPadding),
              child: InkWellButton(
                child: Text('Recently played', style: context.titleMedium),
                onPressed: () {
                  Navigator.pushNamed(context, '/recent');
                },
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}


class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
