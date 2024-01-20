library storybook;

import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

export 'stateful_story.dart';

/// A Storybook is a widget displaying a collection of [Story] widgets.
///
/// The Storybook is a simple [Scaffold] widget that displays its [Story]
/// widgets in vertical [ListView].
///
/// Storybook.
///
///
///

/// ## Sample code
///
/// ```dart
/// runApp(
///     MaterialApp(
///         home: Storybook([
///             TextStory(),
///             ButtonStory(),
///         ])));
/// ```

class Storybook extends StatefulWidget {
  final List<Story> stories;

  const Storybook(this.stories, {super.key});

  @override
  State<Storybook> createState() => _StorybookState();
}

class _StorybookState extends State<Storybook> {
  late WidgetMap _storyContent;

  @override
  void initState() {
    super.initState();

    _storyContent = widget.stories.first.storyContent();
  }

  Widget _menu([bool isMobile = false]) {
    return ListView.builder(
      itemCount: widget.stories.length,
      itemBuilder: (BuildContext context, int index) => widget.stories[index]
        ..addOnStoryTapped = (storyContent) {
          if (isMobile) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => StoryScreen(
                  storyContent.title,
                  storyContent.builder,
                ),
              ),
            );
          } else {
            setState(() {
              _storyContent = storyContent;
            });
          }
        },
    );
  }

  Widget _buildMobileView() {
    return Scaffold(
      appBar: AppBar(
        title: const XText.titleLarge('Storybook'),
      ),
      body: _menu(true),
    );
  }

  Widget _buildDesktopView() {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 280,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey.shade500,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: _menu(),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 64,
                  alignment: Alignment.center,
                  child: XText.titleLarge(_storyContent.title),
                ),
                Expanded(
                  child: _storyContent.builder(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 768.0;

        if (isMobile) return _buildMobileView();
        return _buildDesktopView();
      },
    );
  }
}

/// A Story widget is intended as a single "page" of a [Storybook].  It is
/// intended that authors write their own concrete implementations of Stories
/// to include in a [Storybook].
///
/// A story consists of one or more Widgets.  Each Story is rendered as either
/// a [ExpansionTile] or, in the case when there exists only a single
/// full screen widget, as [ListTile].
///
/// The story's Widget children are arranged as a series of [Row]s within an
/// ExpansionTile, or if the widget is full screen, is displayed by navigating
/// to a route.
///

typedef StoryBuilder = Widget Function(BuildContext context);

class WidgetMap {
  final String title;
  final StoryBuilder builder;

  const WidgetMap({required this.title, required this.builder});
}

class StoryScreen extends StatelessWidget {
  final StoryBuilder builder;
  final String title;

  const StoryScreen(this.title, this.builder, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: XText.titleLarge(title)),
      body: Container(
        child: builder(context),
      ),
    );
  }
}

typedef OnStoryTapped = void Function(WidgetMap);

// ignore: must_be_immutable
abstract class Story extends StatelessWidget {
  Story({super.key});

  WidgetMap storyContent();

  set addOnStoryTapped(OnStoryTapped onPressed) {
    _onStoryPressed = onPressed;
  }

  OnStoryTapped? _onStoryPressed;

  @override
  Widget build(BuildContext context) {
    final content = storyContent();

    return ListTile(
      leading: Icon(Icons.link, color: context.iconColor),
      minLeadingWidth: 8,
      title: Text(content.title),
      onTap: () {
        if (_onStoryPressed != null) {
          return _onStoryPressed!(content);
        }
      },
    );
  }
}

// ─────────── COMMON USED ─────────── //

void noop() {}

const spacer = SizedBox(height: 24);
