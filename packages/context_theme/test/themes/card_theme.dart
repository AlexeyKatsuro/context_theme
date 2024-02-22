import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart';

class CardTheme extends ContextTheme<CardStyle> {
  const CardTheme({
    super.key,
    super.child,
    required super.style,
  });

  static CardStyle of(BuildContext context, [StyleOwnerContext? parent]) {
    return ContextTheme.styleOf<CardStyle, CardTheme>(
      context,
      inheritFrom: parent,
      defaultStyle: DefaultCardStyle.new,
    );
  }
}

extension TestThemeExt on BuildContext {
  CardStyle get cardTheme => CardTheme.of(this);
}

abstract class CardStyle extends Style {
  CardStyle get link => CardTheme.of(context);

  Color get background;

  Color get foreground;
}

class InheritCardStyle extends CardStyle {
  CardStyle get inherit => CardTheme.of(context, parent);

  @override
  Color get background => inherit.background;

  @override
  Color get foreground => inherit.foreground;
}

class DefaultCardStyle extends CardStyle {
  CardStyle get inherit => CardTheme.of(context, parent);

  @override
  Color get background => Colors.white;

  @override
  Color get foreground => Colors.black;
}

class RedBackgroundCardStyle extends InheritCardStyle {
  @override
  Color get background => Colors.red;
}

class RedForegroundCardStyle extends InheritCardStyle {
  @override
  Color get foreground => Colors.red;
}
