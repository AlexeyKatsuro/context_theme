import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../style.dart';

class ColorsTheme extends WidgetTheme<ColorsStyle> {
  const ColorsTheme({
    super.key,
    required super.createStyle,
    required super.child,
  });

  static ColorsStyle of(BuildContext context) {
    return WidgetTheme.styleOf<ColorsStyle, ColorsTheme>(context);
  }
}

extension ColorsThemeExt on BuildContext {
  ColorsStyle get colorsStyle => ColorsTheme.of(this);
}

class ColorsStyle extends Style {

  Brightness get brightness => parent.colorsStyle.brightness;

  Color get primary => parent.colorsStyle.primary;

  Color get onPrimary => parent.colorsStyle.onPrimary;

  Color get accent => parent.colorsStyle.accent;

  Color get onAccent => parent.colorsStyle.onAccent;

  Color get background => parent.colorsStyle.background;
}

class LightColorsStyle extends ColorsStyle {

  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get primary => Colors.deepPurple;

  @override
  Color get onPrimary => Colors.white;

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
  Color get onPrimary => Colors.black87;

  @override
  Color get accent => Colors.cyanAccent.shade700;

  @override
  Color get onAccent => Colors.black;

  @override
  Color get background => const Color(0xFF2A2A2A);
}

