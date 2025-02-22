import 'package:context_theme/context_theme.dart';
import 'package:flutter/widgets.dart';

class FontTheme extends ContextTheme<FontStyle, FontTheme> {
  const FontTheme({
    super.key,
    super.child,
    required super.style,
  });

  static const of = StyleOf<FontStyle, FontTheme>(defaultStyle: DefaultFontStyle.new);
}

extension FontThemeExt on BuildContext {
  FontStyle get fontTheme => FontTheme.of(this);
}

abstract class FontStyle extends Style {
  @override
  FontStyle get link => super.link as FontStyle;

  Color get color;

  double get fontSize;
}

class InheritFontStyle extends FontStyle {
  @override
  FontStyle get inherit => super.inherit as FontStyle;

  @override
  Color get color => inherit.color;

  @override
  double get fontSize => inherit.fontSize;
}

class DefaultFontStyle extends FontStyle {
  @override
  FontStyle get inherit => super.inherit as FontStyle;

  @override
  Color get color => const Color(0x00000000);

  @override
  double get fontSize => 14.0;
}

class SmallFontStyle extends InheritFontStyle {
  @override
  double get fontSize => 12.0;
}

class BigFontStyle extends InheritFontStyle {
  @override
  double get fontSize => 21.0;
}
