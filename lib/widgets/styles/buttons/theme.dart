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

  static ButtonStyle of(BuildContext context) {
    return WidgetTheme.styleOf<ButtonStyle, ButtonTheme>(context);
  }
}

extension ButtonStyleExt on BuildContext {
  ButtonStyle get buttonStyle => ButtonTheme.of(this);
}

class ButtonStyle extends Style {
  Color get primaryColor => parent.buttonStyle.primaryColor;

  Color get onPrimaryColor => parent.buttonStyle.onPrimaryColor;

  Color get backgroundColor => parent.buttonStyle.backgroundColor;

  Color get foregroundColor => parent.buttonStyle.foregroundColor;

  OutlinedBorder get shape => parent.buttonStyle.shape;

  TextStyle? get textStyle => parent.buttonStyle.textStyle;
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
  OutlinedBorder get shape =>
      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)));
}

class PrimaryButtonStyle extends DefaultButtonStyle {
  @override
  Color get primaryColor => context.colorsStyle.primary;

  @override
  Color get onPrimaryColor => context.colorsStyle.onPrimary;
}

class AccentButtonStyle extends DefaultButtonStyle {
  @override
  Color get primaryColor => context.colorsStyle.accent;

  @override
  Color get onPrimaryColor => context.colorsStyle.onAccent;

}
