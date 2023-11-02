import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../style.dart';

class ColorsTheme extends WidgetTheme<ColorsStyle> {
  const ColorsTheme({
    super.key,
    required super.createStyle,
    required super.child,
  });

  static ColorsStyle of(BuildContext context, [StyleOwnerContext? parent]) {
    return WidgetTheme.styleOf<ColorsStyle, ColorsTheme>(context, inheritFrom: parent);
  }
}

extension ColorsThemeExt on BuildContext {
  ColorsStyle get colorsStyle => ColorsTheme.of(this);
}

class ColorsStyle extends Style {

  ColorsStyle get inherit => ColorsTheme.of(context, parent);

  Brightness get brightness => inherit.brightness;

  Color get primary => inherit.primary;

  Color get onPrimary => inherit.onPrimary;

  Color get accent => inherit.accent;

  Color get onAccent => inherit.onAccent;

  Color get background => inherit.background;
}

class LightColorsStyle extends ColorsStyle {

  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get primary => Colors.deepPurple;

  @override
  Color get onPrimary => Colors.red;

  @override
  Color get accent => Colors.cyanAccent;

  @override
  Color get onAccent => Colors.black;

  @override
  Color get background => const Color(0xFFFAFAFA);
}

class DarkColorsStyle extends ColorsStyle {

  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get primary => Colors.deepPurple.shade200;

  @override
  Color get onPrimary => Colors.yellow;

  @override
  Color get accent => Colors.cyanAccent.shade700;

  @override
  Color get onAccent => Colors.black;

  @override
  Color get background => const Color(0xFF2A2A2A);
}

class BlackColorsStyle extends ColorsStyle {

  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get primary => Colors.black;

  @override
  Color get onPrimary => Colors.white;

}

