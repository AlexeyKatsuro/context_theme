import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart';

class CardTheme extends ContextTheme<CardStyle, CardTheme> {
  const CardTheme({
    super.key,
    super.child,
    required super.style,
  }) : super(styleOf: of);

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
  @override
  CardStyle get link => super.link as CardStyle;

  Color get background;

  Color get foreground;

  TextStyle? get textStyle;
}

class InheritCardStyle extends CardStyle {
  @override
  CardStyle get inherit => super.inherit as CardStyle;

  @override
  Color get background => inherit.background;

  @override
  Color get foreground => inherit.foreground;

  @override
  TextStyle? get textStyle => inherit.textStyle;
}

class DefaultCardStyle extends CardStyle {
  @override
  CardStyle get inherit => CardTheme.of(context, parent);

  @override
  Color get background => Colors.white;

  @override
  Color get foreground => Colors.black;

  @override
  TextStyle? get textStyle => const TextStyle(fontSize: 14);
}

class RedBackgroundCardStyle extends InheritCardStyle {
  @override
  Color get background => Colors.red;
}

class RedForegroundCardStyle extends InheritCardStyle {
  @override
  Color get foreground => Colors.red;
}
