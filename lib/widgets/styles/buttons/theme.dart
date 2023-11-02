import 'package:attr_theme/widgets/styles/colors/colors_theme.dart';
import 'package:flutter/material.dart';

import '../colors_styles.dart';
import '../style.dart';

class ButtonTheme extends WidgetTheme<ButtonStyle> {
  const ButtonTheme({
    super.key,
    required super.child,
    required super.createStyle,
  });

  static ButtonStyle of(BuildContext context, [BuildContext? parent]) {
    return WidgetTheme.styleOf<ButtonStyle, ButtonTheme>(context,inheritFrom: parent);
  }
}

extension ButtonStyleExt on BuildContext {
  ButtonStyle get buttonStyle => ButtonTheme.of(this);
}

class ButtonStyle extends Style {
  ButtonStyle get inherit => ButtonTheme.of(context, parent);

  Color get primaryColor => inherit.primaryColor;

  Color get onPrimaryColor => inherit.onPrimaryColor;

  Color get backgroundColor => inherit.backgroundColor;

  Color get foregroundColor => inherit.foregroundColor;

  OutlinedBorder get shape => inherit.shape;

  TextStyle? get textStyle => inherit.textStyle;
}

class DefaultButtonStyle extends ButtonStyle {
  @override
  Color get primaryColor => context.colorsStyle.primary;

  @override
  Color get onPrimaryColor => context.colorsStyle.onPrimary;

  @override
  Color get backgroundColor => primaryColor;

  @override
  Color get foregroundColor => onPrimaryColor;

  @override
  OutlinedBorder get shape => const RoundedRectangleBorder();

  BorderSide? get side => null;

  @override
  TextStyle? get textStyle => Theme.of(context).textTheme.bodyMedium;
}

class RoundedButtonStyle extends ButtonStyle {
  @override
  OutlinedBorder get shape => const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)));
}

class PrimaryButtonStyle extends ButtonStyle {
  @override
  Color get primaryColor => context.colorsStyle.primary;

  @override
  Color get onPrimaryColor => context.colorsStyle.onPrimary;
}

class AccentButtonStyle extends ButtonStyle {
  @override
  Color get primaryColor => context.colorsStyle.accent;

  @override
  Color get onPrimaryColor => context.colorsStyle.onAccent;

}
