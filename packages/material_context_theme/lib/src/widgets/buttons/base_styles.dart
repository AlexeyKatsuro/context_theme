import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' hide ButtonStyle, MaterialStateColor;
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:material_context_theme/src/material_states/material_state_properties.dart';
import 'package:material_context_theme/src/material_states/material_states_extension.dart';
import 'package:material_context_theme/src/theme/colors_theme.dart';

import 'filled_button_styles.dart';

typedef DecorateWrapper = Widget Function(BuildContext context, Widget child);

class ButtonTheme extends WidgetTheme<ButtonStyle> {
  const ButtonTheme({
    super.key,
    super.child,
    required super.style,
  });

  static ButtonStyle of(BuildContext context, [StyleOwnerContext? parent]) {
    return WidgetTheme.styleOf<ButtonStyle, ButtonTheme>(
      context,
      inheritFrom: parent,
      defaultStyle: BaseButtonStyle.new,
    );
  }
}

extension ButtonStyleExt on BuildContext {
  ButtonStyle get buttonStyle => ButtonTheme.of(this);
}

class ButtonStyle extends Style {
  ButtonStyle get inherit => ButtonTheme.of(context, parent);

  ButtonStyle get link => ButtonTheme.of(context);

  Color get primaryColor => inherit.primaryColor;

  Color get onPrimaryColor => inherit.onPrimaryColor;

  TextStyle? get textStyle => inherit.textStyle;

  TextAlign? get textAlign => inherit.textAlign;

  Color? get iconColor => inherit.iconColor;

  double? get iconSize => inherit.iconSize;

  Color? get backgroundColor => inherit.backgroundColor;

  Color? get foregroundColor => inherit.foregroundColor;

  Color? get overlayColor => inherit.overlayColor;

  Color? get shadowColor => inherit.shadowColor;

  Color? get surfaceTintColor => inherit.surfaceTintColor;

  double get elevation => inherit.elevation;

  EdgeInsetsGeometry get padding => inherit.padding;

  Size? get minimumSize => inherit.minimumSize;

  Size? get fixedSize => inherit.fixedSize;

  Size get maximumSize => inherit.maximumSize;

  BorderSide? get side => inherit.side;

  OutlinedBorder get shape => inherit.shape;

  MouseCursor? get mouseCursor => inherit.mouseCursor;

  VisualDensity get visualDensity => inherit.visualDensity;

  MaterialTapTargetSize get tapTargetSize => inherit.tapTargetSize;

  Duration get animationDuration => inherit.animationDuration;

  AlignmentGeometry get alignment => inherit.alignment;

  InteractiveInkFeatureFactory? get splashFactory => inherit.splashFactory;

  DecorateWrapper? get decorator => inherit.decorator;
}

class BaseButtonStyle extends ButtonStyle {
  @override
  Color get primaryColor => context.colorScheme.primary;

  @override
  Color get onPrimaryColor => context.colorScheme.onPrimary;

  @override
  TextAlign? get textAlign => TextAlign.center;

  @override
  Size? get minimumSize => const Size(64.0, 40.0);

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


}

EdgeInsetsGeometry scaledButtonPadding(BuildContext context) {
  final bool useMaterial3 = Theme.of(context).useMaterial3;
  final double padding1x = useMaterial3 ? 24.0 : 16.0;
  return ButtonStyleButton.scaledPadding(
    EdgeInsets.symmetric(horizontal: padding1x),
    EdgeInsets.symmetric(horizontal: padding1x / 2),
    EdgeInsets.symmetric(horizontal: padding1x / 2 / 2),
    MediaQuery.textScaleFactorOf(context),
  );
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
}

class ErrorButtonStyle extends ButtonStyle {
  @override
  Color get primaryColor => context.colorScheme.error;

  @override
  Color get onPrimaryColor => context.colorScheme.onError;
}
