import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/utils/utils.dart';

class MediaPlayerController extends ChangeNotifier {
  static final _singleton = MediaPlayerController._internal();

  factory MediaPlayerController() => _singleton;

  MediaPlayerController._internal();

  final playerDraggableScroll = DraggableScrollableController();
  final watchNextDraggableScroll = DraggableScrollableController();
  List<Color> _gradientColors = [Colors.black, Colors.black];

  void initialize() {
    playerDraggableScroll.addListener(_playerDraggableListener);
    watchNextDraggableScroll.addListener(_watchNextDraggableListener);
  }

  @override
  void dispose() {
    playerDraggableScroll
      ..removeListener(_playerDraggableListener)
      ..dispose();

    watchNextDraggableScroll
      ..removeListener(_watchNextDraggableListener)
      ..dispose();

    super.dispose();
  }

  void _playerDraggableListener() {
    notifyListeners();
  }

  void _watchNextDraggableListener() {}

  double initialPlayerChildSize(BuildContext context) {
    if (playerDraggableScroll.isAttached) {
      return playerDraggableScroll.pixelsToSize(72);
    }
    return 72 / MediaQuery.sizeOf(context).height;
  }

  double minPlayerChildSize(BuildContext context) {
    if (playerDraggableScroll.isAttached) {
      return playerDraggableScroll.pixelsToSize(72);
    }
    return 72 / MediaQuery.sizeOf(context).height;
  }

  double initialWatchNextChildSize(BuildContext context) {
    if (playerSize < 0.7) return 0.0;

    if (watchNextDraggableScroll.isAttached) {
      return watchNextDraggableScroll.pixelsToSize(72);
    }
    return 72 / MediaQuery.sizeOf(context).height;
  }

  double minWatchNextChildSize(BuildContext context) {
    if (playerSize < 0.7) return 0.0;

    if (watchNextDraggableScroll.isAttached) {
      return watchNextDraggableScroll.pixelsToSize(72);
    }
    return 72 / MediaQuery.sizeOf(context).height;
  }

  double maxWatchNextChildSize(BuildContext context) {
    if (!watchNextDraggableScroll.isAttached) return 0.9;

    final height = MediaQuery.sizeOf(context).height;
    return (height - 72) / height;
  }

  Future<void> getGradientColors(MediaItem mediaItem) async {
    _gradientColors = await getLinearColorsFromImage(
      imageProvider: CachedNetworkImageProvider(
        mediaItem.artUri.toString(),
      ),
    );

    notifyListeners();
  }

  bool isMini(BuildContext context) {
    if (!playerDraggableScroll.isAttached) return true;
    return playerSize.toDecimal() <= minPlayerChildSize(context).toDecimal();
  }

  double get playerSize {
    if (!playerDraggableScroll.isAttached) return 0.1;
    return playerDraggableScroll.size;
  }

  double artSize(BuildContext context) {
    double size;
    size = MediaQuery.sizeOf(context).width - horizontalPadding(context) * 2;
    size = size * playerSize;

    if (size <= 48.0) return 48.0;
    return size;
  }

  double replacedHeaderHeight(BuildContext context) {
    final x1 = initialPlayerChildSize(context);
    const x2 = 0.8;
    const y1 = 12.0, y2 = 122.0;
    if (playerSize >= x2) return y2;
    if (isMini(context)) return y1;

    // Apply Linear Interpolation Formula
    // y = y1 + [(y2 - y1)/(x2 - x1)] * (x - x1)

    final slope = (y2 - y1) / (x2 - x1);
    return y1 + slope * (playerSize - x1);
  }

  double? rightPadding() {
    if (playerSize < 0.3) return 0.0;
    return null;
  }

  double horizontalPadding(BuildContext context) {
    final x1 = initialPlayerChildSize(context);
    const x2 = 0.8;
    const y1 = AppConstants.appPadding, y2 = AppConstants.appPadding * 2;
    if (playerSize >= x2) return y2;
    if (isMini(context)) return y1;

    // Apply Linear Interpolation Formula
    // y = y1 + [(y2 - y1)/(x2 - x1)] * (x - x1)

    final slope = (y2 - y1) / (x2 - x1);
    return y1 + slope * (playerSize - x1);
  }

  List<Color> gradientColors(BuildContext context) {
    if (isMini(context)) return [context.cardColor, context.cardColor];
    return _gradientColors;
  }

  void playerAnimateToMinSize() {
    if (!playerDraggableScroll.isAttached) return;
    playerDraggableScroll.reset();
  }

  void playerAnimateToMaxSizeIfNeeded(BuildContext context) {
    if (!isMini(context) || !playerDraggableScroll.isAttached) return;

    playerDraggableScroll.animateTo(
      1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }
}
