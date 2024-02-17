import 'dart:math';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/modules/base/base.dart';
import 'package:melodify/modules/common/common.dart';
import 'package:melodify/modules/routes.dart';
import 'package:melodify/theme/palette.dart';
import 'package:melodify/widgets/widgets.dart';
import 'package:resources/resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreenWithBloc<HomeScreen, HomeBloc> {
  String? _selectedTab;
  final _scrollController = ScrollController();
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
  void initState() {
    super.initState();

    _refresh();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);

    super.dispose();
  }

  void _scrollListener() {
    final ScrollController(:offset, :position) = _scrollController;

    if (offset == position.maxScrollExtent) {
      if (bloc.state.continuation != null) {
        bloc.add(HomeBrowsed());
      }
    }
  }

  Future<void> _refresh() async {
    bloc.add(HomeLoaded());
  }

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
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                current is HomeLoadSuccess ||
                current is HomeBrowseInProgress ||
                current is HomeBrowseSuccess,
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: state.musicCarouselShelfList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final musicCarouselShelf =
                            state.musicCarouselShelfList[index];

                        return switch (musicCarouselShelf.rendererType) {
                          MusicShelfRendererType.responsiveListItem =>
                            MusicResponsiveListItemRenderer(
                              musicCarouselShelf: musicCarouselShelf,
                            ),
                          MusicShelfRendererType.twoRowItem =>
                            MusicTwoRowItemRenderer(
                              musicCarouselShelf: musicCarouselShelf,
                            ),
                        };
                      },
                    ),
                  ),
                  if (state is HomeBrowseInProgress)
                    const SizedBox(
                      height: 80,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                ],
              );
            },
          ),
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
