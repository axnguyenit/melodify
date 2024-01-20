part of 'toast.dart';

/// Widget that controls all animations
class ToastContainer extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismissed;
  final Duration animationDuration;
  final Duration reverseAnimationDuration;
  final Duration displayDuration;
  final VoidCallback? onTap;
  final ControllerCallback? onAnimationControllerInit;
  final bool persistent;
  final EdgeInsets padding;
  final Curve curve;
  final Curve reverseCurve;
  final XSafeArea safeAreaValues;
  final DismissType dismissType;
  final DismissDirection dismissDirection;

  const ToastContainer({
    super.key,
    required this.child,
    required this.onDismissed,
    required this.animationDuration,
    required this.reverseAnimationDuration,
    required this.displayDuration,
    this.onTap,
    this.persistent = false,
    this.onAnimationControllerInit,
    required this.padding,
    required this.curve,
    required this.reverseCurve,
    required this.safeAreaValues,
    this.dismissType = DismissType.onTap,
    this.dismissDirection = DismissDirection.up,
  });

  @override
  State<ToastContainer> createState() => _ToastContainerState();
}

class _ToastContainerState extends State<ToastContainer>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _offsetAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    _initializeAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _initializeAnimation() async {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      reverseDuration: widget.reverseAnimationDuration,
    );

    widget.onAnimationControllerInit?.call(_animationController);

    final offsetTween = Tween<Offset>(
      // begin: const Offset(1.0, -1.0),
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    );

    _offsetAnimation = offsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve,
      ),
    )..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(widget.displayDuration);
          _dismiss();
        }

        if (status == AnimationStatus.dismissed) {
          if (mounted) {
            widget.onDismissed.call();
          }
        }
      });

    if (mounted) {
      await _animationController.forward();
    }
  }

  void _dismiss() {
    if (!widget.persistent && mounted) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.padding.top,
      left: widget.padding.left,
      right: widget.padding.right,
      child: SlideTransition(
        position: _offsetAnimation,
        child: SafeArea(
          top: widget.safeAreaValues.top,
          bottom: widget.safeAreaValues.bottom,
          left: widget.safeAreaValues.left,
          right: widget.safeAreaValues.right,
          minimum: widget.safeAreaValues.minimum,
          maintainBottomViewPadding:
              widget.safeAreaValues.maintainBottomViewPadding,
          child: _buildDismissibleChild(),
        ),
      ),
    );
  }

  /// Build different type of [Widget] depending on [DismissType] value
  Widget _buildDismissibleChild() {
    switch (widget.dismissType) {
      case DismissType.onTap:
        return GestureDetector(
          onTap: () {
            if (mounted) {
              widget.onTap?.call();
              _dismiss();
            }
          },
          child: widget.child,
        );
      case DismissType.onSwipe:
        return Dismissible(
          direction: widget.dismissDirection,
          key: UniqueKey(),
          onDismissed: (direction) => _dismiss(),
          child: widget.child,
        );
      case DismissType.none:
        return widget.child;
    }
  }
}
