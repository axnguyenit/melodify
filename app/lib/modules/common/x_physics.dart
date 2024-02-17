import 'package:flutter/material.dart';

class XPageScrollPhysics extends ScrollPhysics {
  final double itemDimension;

  const XPageScrollPhysics({required this.itemDimension, super.parent});

  @override
  XPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return XPageScrollPhysics(
      itemDimension: itemDimension,
      parent: buildParent(ancestor),
    );
  }

  double _getPage(ScrollMetrics position) {
    return position.pixels / itemDimension;
  }

  double _getPixels(double page) {
    return page * itemDimension;
  }

  double _getTargetPixels(
    ScrollMetrics position,
    Tolerance tolerance,
    double velocity,
  ) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return _getPixels(page.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final ScrollMetrics(:pixels, :minScrollExtent, :maxScrollExtent) = position;
    if ((velocity <= 0.0 && pixels <= minScrollExtent) ||
        (velocity >= 0.0 && pixels >= maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    final tolerance = toleranceFor(position);
    final target = _getTargetPixels(position, tolerance, velocity);

    if (target == pixels) return null;

    return ScrollSpringSimulation(
      spring,
      pixels,
      target,
      velocity,
      tolerance: tolerance,
    );
  }

  @override
  bool get allowImplicitScrolling => false;
}
