import 'package:attr_theme/widgets/styles/colors/colors_theme.dart';
import 'package:attr_theme/widgets/styles/style.dart';
import 'package:flutter/material.dart' hide ButtonStyle;

class ButtonTheme extends WidgetTheme<ButtonStyle> {
  const ButtonTheme({
    super.key,
    super.child,
    required super.style,
  });

  static ButtonStyle of(BuildContext context, [StyleOwnerContext? parent]) {
    return WidgetTheme.styleOf<ButtonStyle, ButtonTheme>(context, inheritFrom: parent);
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

  Duration? get animationDuration => inherit.animationDuration;

  AlignmentGeometry get alignment => inherit.alignment;

  InteractiveInkFeatureFactory? get splashFactory => inherit.splashFactory;
}

class BaseButtonStyle extends ButtonStyle {


  @override
  TextAlign? get textAlign => TextAlign.center;

  @override
  Size? get minimumSize => const Size(64.0, 40.0);

  @override
  Size get maximumSize => Size.infinite;

  @override
  Color? get iconColor => null;

  @override
  double? get iconSize => null;

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
  Duration? get animationDuration => kThemeChangeDuration;

  @override
  AlignmentGeometry get alignment => Alignment.center;

  @override
  InteractiveInkFeatureFactory? get splashFactory => Theme.of(context).splashFactory;
}

class ErrorButtonStyle extends ButtonStyle {

  @override
  Color get primaryColor => context.colorScheme.error;

  @override
  Color get onPrimaryColor => context.colorScheme.onError;
}


