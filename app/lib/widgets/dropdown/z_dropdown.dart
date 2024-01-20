import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:melodify/constants/constants.dart';
import 'package:melodify/widgets/widgets.dart';

/// A [FormField] that contains a [XDropdown].
///
/// This is a convenience widget that wraps a [XDropdown] widget in a
/// [FormField].
///
/// A [Form] ancestor is not required. The [Form] allows one to
/// save, reset, or validate multiple fields at once. To use without a [Form],
/// pass a `GlobalKey<FormFieldState>` (see [GlobalKey]) to the constructor and
/// use [GlobalKey.currentState] to save or reset the form field.
class ZDropdown<T> extends FormField<T> {
  final ValueChanged<T?> onChanged;
  final DropdownController? controller;

  ZDropdown({
    super.key,
    super.autovalidateMode,
    String? label,
    String? errorMessage,
    String placeholder = 'Select your option',
    GlobalKey? parentKey,
    Border? border,
    TextStyle? itemStyle,
    TextStyle? labelStyle,
    TextStyle? selectedStyle,
    TextStyle? errorTextStyle,
    TextStyle? placeholderStyle,
    double dropdownItemHeight = AppConstants.formFieldHeight,
    BorderRadius? borderRadius,
    double maxDropdownBoxHeight = 200,
    double dropdownButtonHeight = AppConstants.formFieldHeight,
    bool required = true,
    required List<T> items,
    required T? selectedValue,
    required XDropdownItemBuilder<T> itemBuilder,
    required this.onChanged,
    this.controller,
    Color? labelBackground,
  })  : assert(
          items.isNotEmpty,
          'There should be at least one element in "items"',
        ),
        assert(
          !(required && errorMessage.isNullOrEmpty),
          '"errorMessage should be provided when "required" is true',
        ),
        super(
          initialValue: selectedValue,
          validator: (value) {
            if (!required || value != null) return null;

            return errorMessage;
          },
          builder: (FormFieldState<T> field) {
            final _ZDropdownState<T> state = field as _ZDropdownState<T>;

            const decoration = InputDecoration();
            final effectiveDecoration = decoration.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );

            return Focus(
              canRequestFocus: false,
              skipTraversal: true,
              child: Builder(
                builder: (context) {
                  final bool isFocused = Focus.of(context).hasFocus;
                  InputBorder? resolveInputBorder() {
                    if (state.hasError) {
                      if (isFocused) {
                        return effectiveDecoration.focusedErrorBorder;
                      }

                      return effectiveDecoration.errorBorder;
                    }

                    if (isFocused) {
                      return effectiveDecoration.focusedBorder;
                    }

                    if (effectiveDecoration.enabled) {
                      return effectiveDecoration.enabledBorder;
                    }

                    return effectiveDecoration.border;
                  }

                  final inputBorder = resolveInputBorder();

                  BorderRadius? effectiveBorderRadius() {
                    if (borderRadius != null) return borderRadius;

                    if (inputBorder is OutlineInputBorder) {
                      return inputBorder.borderRadius;
                    }

                    if (inputBorder is UnderlineInputBorder) {
                      return inputBorder.borderRadius;
                    }

                    return null;
                  }

                  Border? resolveBorder() {
                    if (border != null) return border;

                    if (inputBorder is OutlineInputBorder) {
                      return Border.fromBorderSide(inputBorder.borderSide);
                    }

                    if (inputBorder is UnderlineInputBorder) {
                      return Border.fromBorderSide(inputBorder.borderSide);
                    }

                    return null;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      XDropdown<T>(
                        items: items,
                        label: label,
                        placeholder: placeholder,
                        errorMessage: state.errorText,
                        selectedValue: state.value,
                        onSelected: state.didChange,
                        itemBuilder: itemBuilder,
                        parentKey: parentKey,
                        border: resolveBorder(),
                        itemStyle: itemStyle,
                        labelStyle: labelStyle,
                        selectedStyle: selectedStyle,
                        errorTextStyle: errorTextStyle,
                        placeholderStyle: placeholderStyle,
                        dropdownItemHeight: dropdownItemHeight,
                        borderRadius: effectiveBorderRadius(),
                        maxDropdownBoxHeight: maxDropdownBoxHeight,
                        dropdownButtonHeight: dropdownButtonHeight,
                        labelBackground: labelBackground,
                      ),
                    ],
                  );

                  // return Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     ListenableBuilder(
                  //       listenable: controller,
                  //       builder: (_, __) {
                  //         return XDropdown<T>(
                  //           items: items,
                  //           label: label,
                  //           placeholder: placeholder,
                  //           errorMessage: state.errorText,
                  //           selectedValue: state.value,
                  //           onSelected: state.didChange,
                  //           itemBuilder: itemBuilder,
                  //           parentKey: parentKey,
                  //           border: resolveBorder(),
                  //           itemStyle: itemStyle,
                  //           labelStyle: labelStyle,
                  //           selectedStyle: selectedStyle,
                  //           errorTextStyle: errorTextStyle,
                  //           placeholderStyle: placeholderStyle,
                  //           dropdownItemHeight: dropdownItemHeight,
                  //           borderRadius: effectiveBorderRadius(),
                  //           maxDropdownBoxHeight: maxDropdownBoxHeight,
                  //           dropdownButtonHeight: dropdownButtonHeight,
                  //         );
                  //       },
                  //     ),
                  //   ],
                  // );
                },
              ),
            );
          },
        );

  @override
  FormFieldState<T> createState() => _ZDropdownState<T>();
}

class _ZDropdownState<T> extends FormFieldState<T> {
  ZDropdown<T> get _widget => widget as ZDropdown<T>;

  @override
  void didChange(T? value) {
    super.didChange(value);
    _widget.onChanged(value);
    validate();
  }

  @override
  void didUpdateWidget(ZDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setValue(widget.initialValue);
    }
  }

  @override
  void reset() {
    super.reset();
    _widget.onChanged(value);
  }
}

// ────────────────────────────────────────────
// TODO(ax): Create controller to manage XDropdown/XDropdown
class DropdownController<T> extends ChangeNotifier {
  DropdownController({
    T? value,
  }) : _value = value;

  T? _value;

  T? get value => _value;

  set value(T? value) {
    _value = value;
    notifyListeners();
  }
}
