import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' as material show ButtonStyle;
import 'package:flutter/material.dart' hide ButtonStyle, ButtonTheme;

import '../../material_states/index.dart';
import '../decorator/index.dart';
import 'base_styles.dart';

mixin MaterialButtonBuilder on Widget {}

typedef StyleOfContext<S extends Style> = S Function(BuildContext);

class MaterialButton extends StatefulWidget with MaterialButtonBuilder {
  const MaterialButton({
    super.key,
    Clip? clipBehavior,
    required this.onPressed,
    this.onLongPress,
    this.onFocusChange,
    this.onHover,
    this.focusNode,
    bool? autofocus,
    bool? enabled,
    StyleOfContext<ButtonStyle>? styleOf,
    required this.child,
  })  : clipBehavior = clipBehavior ?? Clip.none,
        styleOf = styleOf ?? ButtonTheme.of,
        autofocus = autofocus ?? false,
        enabled = enabled ?? onPressed != null || onLongPress != null;

  final StyleOfContext<ButtonStyle> styleOf;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final ValueChanged<bool>? onFocusChange;

  final ValueChanged<bool>? onHover;

  final FocusNode? focusNode;

  final bool autofocus;

  final Widget child;

  final Clip clipBehavior;

  final bool enabled;

  @override
  State<MaterialButton> createState() => _MaterialButtonState();
}

class _MaterialButtonState extends State<MaterialButton> {
  late final MaterialStatesController _statesController =
      MaterialStatesController({if (!widget.enabled) MaterialState.disabled});

  @override
  void didUpdateWidget(covariant MaterialButton oldWidget) {
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
    final style = widget.styleOf(context);
    return MaterialStateScope.controller(
      controller: _statesController,
      child: style.decorator.apply(
        builder: (context) {
          return _ButtonBridge(
            style: widget.styleOf(context),
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
        },
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
      iconSize: iconSize.toMaterialStateProperty(),
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
