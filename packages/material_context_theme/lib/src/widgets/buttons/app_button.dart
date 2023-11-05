import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:flutter/material.dart' as material show  ButtonStyle;
import 'package:material_context_theme/src/material_states/material_state_scope.dart';
import 'package:material_context_theme/src/widgets/buttons/base_styles.dart';


/// The base [StatefulWidget] class for buttons whose style is defined by a [AppButtonThemeData] object.
///
/// Using this directly is not recommended, because this widget does not have most styles,
/// and is the base class for stylized button types.
///
/// See:
/// * [AppButtonFilled], similar to material [ElevatedButton].
/// * [AppButtonOutlined], similar to material [OutlinedButton].
/// * [AppButtonToggleable], variant of button that can be selected and unselected.
class AppButton extends StatefulWidget {
  const AppButton({
    Key? key,
    Clip? clipBehavior,
    required this.onPressed,
    this.onLongPress,
    this.onFocusChange,
    this.onHover,
    this.focusNode,
    bool? autofocus = false,
    bool? enabled,
    required this.child,
  })  : clipBehavior = clipBehavior ?? Clip.none,
        autofocus = autofocus ?? false,
        enabled = enabled ?? onPressed != null || onLongPress != null,
        super(key: key);

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback and [onLongPress] are null, then the button will be disabled.
  final VoidCallback? onPressed;

  /// Called when the button is long-pressed.
  ///
  /// If this callback and [onPressed] are null, then the button will be disabled.
  final VoidCallback? onLongPress;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses
  /// focus.
  final ValueChanged<bool>? onFocusChange;

  /// Called when a pointer enters or exits the button response area.
  ///
  /// The value passed to the callback is true if a pointer has entered this
  /// part of the material and false if a pointer has exited this part of the
  /// material.
  final ValueChanged<bool>? onHover;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Typically the button's label.
  final Widget child;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none], and must not be null.
  final Clip clipBehavior;

  /// Whether the button is enabled or disabled.
  ///
  /// Buttons are disabled by default. To enable a button, set its [onPressed]
  /// or [onLongPress] properties to a non-null value.
  final bool enabled;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  late final MaterialStatesController _statesController =
  MaterialStatesController({if (!widget.enabled) MaterialState.disabled});

  @override
  void didUpdateWidget(covariant AppButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _statesController.update(MaterialState.disabled, !widget.enabled);
  }

  @override
  void dispose() {
    _statesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialStateScope(
      states: _statesController,
      child: Builder(
        builder: (context) {
          return _ButtonBridge(
            style: context.buttonStyle,
            statesController: _statesController,
            clipBehavior: widget.clipBehavior,
            onPressed: widget.enabled ? widget.onPressed : null,
            onLongPress: widget.enabled ? widget.onLongPress : null,
            onFocusChange: widget.enabled ? widget.onFocusChange : null,
            onHover: widget.enabled ? widget.onHover : null,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            child: widget.child,
          );
        }
      ),
    );
  }
}

class _ButtonBridge extends ButtonStyleButton {
  _ButtonBridge({
    required ButtonStyle style,
    required super.onPressed,
    required super.onLongPress,
    required super.onHover,
    required super.onFocusChange,
    required super.focusNode,
    required super.autofocus,
    required super.clipBehavior,
    required super.statesController,
    required Widget child,
  }) : super(
    style: style.toMaterial(),
    child: DefaultTextStyle.merge(child: child, textAlign: style.textAlign),
  );

  @override
  material.ButtonStyle defaultStyleOf(BuildContext context) => style!;

  @override
  material.ButtonStyle? themeStyleOf(BuildContext context) => null;
}

extension on ButtonStyle {
  material.ButtonStyle toMaterial() {
    return material.ButtonStyle(
      textStyle: textStyle.toMaterialStateProperty(),
      iconColor: iconColor.toMaterialStateProperty(),
      iconSize: iconSize?.toMaterialStateProperty(),
      backgroundColor: backgroundColor.toMaterialStateProperty(),
      foregroundColor: foregroundColor.toMaterialStateProperty(),
      overlayColor: overlayColor.toMaterialStateProperty(),
      shadowColor: shadowColor.toMaterialStateProperty(),
      elevation: elevation.toMaterialStateProperty(),
      padding: padding.toMaterialStateProperty(),
      minimumSize: minimumSize.toMaterialStateProperty(),
      fixedSize: fixedSize.toMaterialStateProperty(),
      maximumSize: maximumSize.toMaterialStateProperty(),
      side: side.toMaterialStateProperty(),
      shape: shape.toMaterialStateProperty(),
      mouseCursor: mouseCursor.toMaterialStateProperty(),
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      alignment: alignment,
      splashFactory: splashFactory,
    );
  }
}


extension MaterialStatePropertyTransform<T> on T {
  MaterialStateProperty<T>? toMaterialStateProperty() {
    final value = this;
    if (value == null) return null;
    if (value is MaterialStateProperty<T>) return value;
    return MaterialStatePropertyAll<T>(value);
  }
}
