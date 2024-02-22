import 'package:context_theme/context_theme.dart';
import 'package:flutter/widgets.dart';

class FontTheme extends ContextTheme<FontStyle> {
  const FontTheme({
    super.key,
    super.child,
    required super.style,
  });

  static FontStyle of(BuildContext context, [StyleOwnerContext? parent]) {
    return ContextTheme.styleOf<FontStyle, FontTheme>(
      context,
      inheritFrom: parent,
      defaultStyle: DefaultFontStyle.new,
    );
  }
}

extension FontThemeExt on BuildContext {
  FontStyle get fontTheme => FontTheme.of(this);
}

abstract class FontStyle extends Style {
  FontStyle get link => FontTheme.of(context);

  Color get color;

  double get fontSize;
}

class InheritFontStyle extends FontStyle {
  FontStyle get inherit => FontTheme.of(context, parent);

  @override
  Color get color => inherit.color;

  @override
  double get fontSize => inherit.fontSize;
}

class DefaultFontStyle extends FontStyle {
  FontStyle get inherit => FontTheme.of(context, parent);

  @override
  Color get color => const Color(0x000000);

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
