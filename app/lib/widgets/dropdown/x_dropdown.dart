import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

import 'error_message.dart';
import 'shaker.dart';

typedef XDropdownItemBuilder<T> = Widget Function(BuildContext context, T item);

const Duration _kTransitionDuration = Duration(milliseconds: 167);
const Curve _kTransitionCurve = Curves.fastOutSlowIn;

class XDropdown<T> extends StatefulWidget {
  final String? label;
  final String placeholder;
  final GlobalKey? parentKey;
  final String? errorMessage;
  final Border? border;
  final TextStyle? itemStyle;
  final TextStyle? labelStyle;
  final TextStyle? selectedStyle;
  final TextStyle? errorTextStyle;
  final TextStyle? placeholderStyle;
  final double dropdownItemHeight;
  final BorderRadius? borderRadius;
  final double maxDropdownBoxHeight;
  final double dropdownButtonHeight;
  final Color? labelBackground;
  final List<T> items;
  final T? selectedValue;
  final ValueChanged<T?> onSelected;
  final XDropdownItemBuilder<T> itemBuilder;

  // ────────────────────────────────────────────

  XDropdown({
    super.key,
    this.label,
    this.placeholder = 'Select your option',
    this.parentKey,
    this.errorMessage,
    this.border,
    this.itemStyle,
    this.labelStyle,
    this.selectedStyle,
    this.errorTextStyle,
    this.placeholderStyle,
    this.dropdownItemHeight = AppConstants.formFieldHeight,
    this.borderRadius,
    this.maxDropdownBoxHeight = 200,
    this.dropdownButtonHeight = AppConstants.formFieldHeight,
    this.labelBackground,
    required this.items,
    required this.selectedValue,
    required this.onSelected,
    required this.itemBuilder,
  }) : assert(
          items.isNotEmpty,
          'There should be at least one element in "items"',
        );

  @override
  State<XDropdown<T>> createState() => _XDropdownState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<String?>(
          'label',
          label,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<String>(
          'placeholder',
          placeholder,
          defaultValue: 'Select your option',
        ),
      )
      ..add(
        DiagnosticsProperty<List<T>>(
          'items',
          items,
          defaultValue: [],
        ),
      )
      ..add(
        DiagnosticsProperty<T?>(
          'selectedValue',
          selectedValue,
          defaultValue: null,
        ),
      );
  }
}

class _XDropdownState<T> extends State<XDropdown<T>>
    with TickerProviderStateMixin {
  final GlobalKey _actionKey = LabeledGlobalKey('dropdown_action_key');
  double _height = 0, _width = 0, _xPosition = 0, _yPosition = 0;
  bool _isDropdownOpened = false;
  late final OverlayEntry _floatingDropdown;
  late final AnimationController _shakingLabelController;

  @override
  void initState() {
    super.initState();

    _floatingDropdown = _createFloatingDropdown();
    _shakingLabelController = AnimationController(
      duration: _kTransitionDuration,
      vsync: this,
    );
  }

  void _findDropdownData() {
    final renderBox =
        _actionKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    _height = renderBox.size.height;
    _width = renderBox.size.width;

    final spacing = MediaQuery.of(context).size.height - offset.dy;
    final dropdownBoxHeight = _calculateDropdownBoxHeight();

    _xPosition = offset.dx;
    if (spacing < dropdownBoxHeight) {
      _yPosition = offset.dy - dropdownBoxHeight - _height;
    } else {
      _yPosition = offset.dy;
    }

    if (widget.parentKey != null) {
      final parentBox =
          widget.parentKey!.currentContext!.findRenderObject() as RenderBox;
      final parentOffset = parentBox.localToGlobal(Offset.zero);

      _xPosition -= parentOffset.dx;
      _yPosition -= parentOffset.dy;
    }
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: const MaterialStatePropertyAll(
                    Colors.transparent,
                  ),
                  onTap: _toggleDropdown,
                  child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
            ),
            Positioned(
              left: _xPosition,
              top: _yPosition + _height,
              width: _width,
              child: _buildDropdown(context),
            ),
          ],
        );
      },
    );
  }

  void _toggleDropdown() {
    if (_isDropdownOpened) {
      _floatingDropdown.remove();
      setState(() {
        _isDropdownOpened = false;
      });
    } else {
      _findDropdownData();
      Overlay.of(context).insert(_floatingDropdown);
      setState(() {
        _isDropdownOpened = true;
      });
    }
  }

  Widget _buildSelectedItem(bool hasSelectedValue) {
    if (hasSelectedValue) {
      return widget.itemBuilder(context, widget.selectedValue as T);
    }

    return Text(
      widget.placeholder,
      style: (widget.placeholderStyle ?? context.bodyMedium)!.copyWith(
        color: hasSelectedValue ? context.textColor : context.disabledColor,
      ),
    );
  }

  @override
  void dispose() {
    _floatingDropdown.dispose();
    _shakingLabelController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasSelectedValue = widget.selectedValue != null;

    return PopScope(
      onPopInvoked: (_) {
        if (_isDropdownOpened) {
          _toggleDropdown();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              InkWellButton(
                key: _actionKey,
                borderRadius: widget.borderRadius ??
                    BorderRadius.circular(
                      AppConstants.formFieldBorderRadius,
                    ),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                onPressed: _toggleDropdown,
                border: widget.border ??
                    Border.fromBorderSide(
                        context.inputDecorationTheme.enabledBorder!.borderSide),
                padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
                height: widget.dropdownButtonHeight,
                child: Row(
                  children: <Widget>[
                    _buildSelectedItem(hasSelectedValue),
                    const Spacer(),
                    Icon(
                      _isDropdownOpened
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 24,
                      color: hasSelectedValue
                          ? context.textColor
                          : context.iconColor,
                    ),
                  ],
                ),
              ),
              if (widget.label.isNotNullOrEmpty) ...[
                Positioned(
                  top: -4,
                  left: AppConstants.inputContentPadding.left - 4,
                  child: Shaker(
                    animation: _shakingLabelController.view,
                    child: AnimatedDefaultTextStyle(
                      duration: _kTransitionDuration,
                      curve: _kTransitionCurve,
                      style: context.inputDecorationTheme.floatingLabelStyle!,
                      child: Container(
                        color:
                            widget.labelBackground ?? context.backgroundColor,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          widget.label!,
                          style: (widget.labelStyle ?? context.labelSmall)
                              ?.copyWith(
                            fontSize: 10.5,
                            height: 1,
                            color: widget.errorMessage.isNullOrEmpty
                                ? context.disabledColor
                                : context.errorColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          ErrorMessage(
            message: widget.errorMessage,
            duration: _kTransitionDuration,
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(XDropdown<T> old) {
    super.didUpdateWidget(old);

    if (widget.errorMessage != null &&
        widget.errorMessage != old.errorMessage) {
      _shakingLabelController
        ..value = 0.0
        ..forward();
    }
  }

  double _calculateDropdownBoxHeight() {
    final dropdownBoxHeight =
        (widget.dropdownItemHeight) * widget.items.length +
            ((widget.items.length - 1) * 4) +
            16;
    // 16: padding vertical * 2
    // 4: separator sizedBox height
    if (widget.maxDropdownBoxHeight > dropdownBoxHeight) {
      return dropdownBoxHeight;
    }
    return widget.maxDropdownBoxHeight;
  }

  Widget _buildDropdown(BuildContext context) {
    return Container(
      height: _calculateDropdownBoxHeight(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: widget.borderRadius ??
            BorderRadius.circular(AppConstants.formFieldBorderRadius * 1.5),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 2,
            spreadRadius: 0,
            color: context.shadowColor.withOpacity(0.24),
          ),
          BoxShadow(
            offset: const Offset(-20, 20),
            blurRadius: 40,
            spreadRadius: -4,
            color: context.shadowColor.withOpacity(0.24),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: widget.items.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        separatorBuilder: (_, __) => const SizedBox(height: 4),
        itemBuilder: (context, index) {
          return InkWellButton(
            height: widget.dropdownItemHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            borderRadius: widget.borderRadius ??
                BorderRadius.circular(AppConstants.formFieldBorderRadius),
            backgroundColor: widget.selectedValue == widget.items[index]
                ? context.highlightColor
                : null,
            onPressed: () {
              _toggleDropdown();
              widget.onSelected(widget.items[index]);
            },
            child: widget.itemBuilder(context, widget.items[index]),
          );
        },
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
