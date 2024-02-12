import 'dart:math' as math;
import 'dart:ui';

import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' hide ButtonStyle, MaterialStateColor;

import '../../material_states/material_state_properties.dart';
import '../../material_states/material_state_scope.dart';
import '../../material_states/material_states_extension.dart';
import '../../theme/colors_theme.dart';
import '../decorator/index.dart';
import 'button.dart';

class ButtonTheme extends ContextTheme<ButtonStyle> with MaterialButtonBuilder {
  const ButtonTheme({
    super.key,
    super.child,
    required super.style,
  });

  static ButtonStyle of(BuildContext context, [StyleOwnerContext? parent]) {
    return ContextTheme.styleOf<ButtonStyle, ButtonTheme>(
      context,
      inheritFrom: parent,
      defaultStyle: DefaultButtonStyle.new,
    );
  }
}

extension ButtonStyleExt on BuildContext {
  ButtonStyle get buttonStyle => ButtonTheme.of(this);
}

abstract class ButtonStyle extends Style {
  ButtonStyle get link => ButtonTheme.of(context);

  Color get primaryColor;

  Color get onPrimaryColor;

  TextStyle? get textStyle;

  TextAlign? get textAlign;

  Color? get iconColor;

  double? get iconSize;

  double get iconGap;

  Color? get backgroundColor;

  Color? get foregroundColor;

  Color? get overlayColor;

  Color? get shadowColor;

  Color? get surfaceTintColor;

  double get elevation;

  EdgeInsetsGeometry get padding;

  Size? get minimumSize;

  Size? get fixedSize;

  Size get maximumSize;

  BorderSide? get side;

  OutlinedBorder get shape;

  MouseCursor? get mouseCursor;

  VisualDensity get visualDensity;

  MaterialTapTargetSize get tapTargetSize;

  Duration get animationDuration;

  AlignmentGeometry get alignment;

  InteractiveInkFeatureFactory? get splashFactory;

  DecorateWrapper? get decorator;
}

class InheritButtonStyle extends ButtonStyle {
  ButtonStyle get inherit => ButtonTheme.of(context, parent);

  @override
  Color get primaryColor => inherit.primaryColor;

  @override
  Color get onPrimaryColor => inherit.onPrimaryColor;

  @override
  TextStyle? get textStyle => inherit.textStyle;

  @override
  TextAlign? get textAlign => inherit.textAlign;

  @override
  Color? get iconColor => inherit.iconColor;

  @override
  double? get iconSize => inherit.iconSize;

  @override
  Color? get backgroundColor => inherit.backgroundColor;

  @override
  Color? get foregroundColor => inherit.foregroundColor;

  @override
  Color? get overlayColor => inherit.overlayColor;

  @override
  Color? get shadowColor => inherit.shadowColor;

  @override
  Color? get surfaceTintColor => inherit.surfaceTintColor;

  @override
  double get elevation => inherit.elevation;

  @override
  EdgeInsetsGeometry get padding => inherit.padding;

  @override
  Size? get minimumSize => inherit.minimumSize;

  @override
  Size? get fixedSize => inherit.fixedSize;

  @override
  Size get maximumSize => inherit.maximumSize;

  @override
  BorderSide? get side => inherit.side;

  @override
  OutlinedBorder get shape => inherit.shape;

  @override
  MouseCursor? get mouseCursor => inherit.mouseCursor;

  @override
  VisualDensity get visualDensity => inherit.visualDensity;

  @override
  MaterialTapTargetSize get tapTargetSize => inherit.tapTargetSize;

  @override
  Duration get animationDuration => inherit.animationDuration;

  @override
  AlignmentGeometry get alignment => inherit.alignment;

  @override
  InteractiveInkFeatureFactory? get splashFactory => inherit.splashFactory;

  @override
  DecorateWrapper? get decorator => inherit.decorator;

  @override
  double get iconGap => inherit.iconGap;
}

class DefaultButtonStyle extends ButtonStyle {
  @override
  Color get primaryColor => context.colorScheme.primary;

  @override
  Color get onPrimaryColor => context.colorScheme.onPrimary;

  @override
  TextAlign? get textAlign => TextAlign.center;

  @override
  Size? get minimumSize => const Size(64, 40);

  @override
  Size get maximumSize => Size.infinite;

  @override
  Color? get iconColor => null;

  @override
  Color? get shadowColor => context.colorScheme.shadow;

  @override
  Color? get surfaceTintColor => Colors.transparent;

  @override
  double? get iconSize => 24;

  @override
  TextStyle? get textStyle => Theme.of(context).textTheme.labelLarge;

  @override
  OutlinedBorder get shape => const StadiumBorder();

  @override
  MouseCursor? get mouseCursor => MaterialStateMouseCursor.clickable;

  @override
  VisualDensity get visualDensity => Theme.of(context).visualDensity;

  @override
  MaterialTapTargetSize get tapTargetSize => Theme.of(context).materialTapTargetSize;

  @override
  Size? get fixedSize => null;

  @override
  BorderSide? get side => null;

  @override
  Duration get animationDuration => kThemeChangeDuration;

  @override
  EdgeInsetsGeometry get padding => scaledButtonPadding(context);

  @override
  AlignmentGeometry get alignment => Alignment.center;

  @override
  InteractiveInkFeatureFactory? get splashFactory => Theme.of(context).splashFactory;

  @override
  DecorateWrapper? get decorator => null;

  @override
  Color? get backgroundColor => link.primaryColor;

  @override
  double get elevation => 0;

  @override
  Color? get foregroundColor => link.onPrimaryColor;

  @override
  Color? get overlayColor => OverlayMaterialStateColor(link.onPrimaryColor);

  @override
  double get iconGap => scaledButtonIconGap(context, 8);
}

EdgeInsetsGeometry scaledButtonPadding(BuildContext context) {
  final useMaterial3 = Theme.of(context).useMaterial3;
  final padding1x = useMaterial3 ? 24.0 : 16.0;
  return ButtonStyleButton.scaledPadding(
    EdgeInsets.symmetric(horizontal: padding1x),
    EdgeInsets.symmetric(horizontal: padding1x / 2),
    EdgeInsets.symmetric(horizontal: padding1x / 2 / 2),
    MediaQuery.textScaleFactorOf(context),
  );
}

double scaledButtonIconGap(BuildContext context, double origin) {
  final scale = MediaQuery.textScalerOf(context).scale(origin) / origin;
  // Adjust the gap based on the text scale factor. Start at 8, and lerp
  // to 4 based on how large the text is.
  return scale <= 1 ? origin : lerpDouble(origin, origin / 2, math.min(scale - 1, 1))!;
}

class OverlayMaterialStateColor extends MaterialStateColor {
  OverlayMaterialStateColor(Color highlight)
      : super.resolveWith((states) {
          if (states.isPressed) {
            return highlight.withOpacity(0.12);
          }
          if (states.isHovered) {
            return highlight.withOpacity(0.08);
          }
          if (states.isFocused) {
            return highlight.withOpacity(0.12);
          }
          return null;
        });

  Color? resolveWith(BuildContext context) {
    return resolve({
      if (context.isPressed) MaterialState.pressed,
      if (context.isHovered) MaterialState.hovered,
      if (context.isFocused) MaterialState.focused,
    });
  }
}

class ErrorButtonStyle extends InheritButtonStyle {
  @override
  Color get primaryColor => context.colorScheme.error;

  @override
  Color get onPrimaryColor => context.colorScheme.onError;
}
