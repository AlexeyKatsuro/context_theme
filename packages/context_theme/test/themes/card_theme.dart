import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart';

class CardTheme extends ContextTheme<CardStyle, CardTheme> {
  const CardTheme({
    super.key,
    super.child,
    required super.style,
  });

  static const of = StyleOf<CardStyle, CardTheme>(defaultStyle: DefaultCardStyle.new);
}

extension TestThemeExt on BuildContext {
  CardStyle get cardTheme => CardTheme.of(this);
}

abstract class CardStyle extends Style with TypedStyle<CardStyle> {
  Color get background;

  Color get foreground;

  TextStyle? get textStyle;
}

class InheritCardStyle = CardStyle with InheritStyle, InheritCardStyleMixin;
mixin InheritCardStyleMixin on CardStyle {
  @override
  StyleOfContext<CardStyle> get inheritFrom => CardTheme.of;

  @override
  Color get background => inherit.background;

  @override
  Color get foreground => inherit.foreground;

  @override
  TextStyle? get textStyle => inherit.textStyle;
}

class DefaultCardStyle extends CardStyle {
  static const kBackground = Colors.white;
  static const kForeground = Colors.black;

  @override
  Color get background => Colors.white;

  @override
  Color get foreground => Colors.black;

  @override
  TextStyle? get textStyle => TextStyle(fontSize: 14, color: link.foreground);
}

class RedBackgroundCardStyle = InheritCardStyle with RedBackgroundCardStyleMixin;
mixin RedBackgroundCardStyleMixin on CardStyle {
  static const kBackground = Colors.red;

  @override
  Color get background => kBackground;
}

class RedForegroundCardStyle = InheritCardStyle with RedForegroundCardStyleMixin;
mixin RedForegroundCardStyleMixin on CardStyle {
  static const kForeground = Colors.red;

  @override
  Color get foreground => kForeground;
}
