import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' hide CardTheme;

import 'card_theme.dart';

class VariantCardTheme extends ContextTheme<CardStyle, VariantCardTheme> {
  const VariantCardTheme({
    super.key,
    super.child,
    required super.style,
  });

  static const of = StyleOf<CardStyle, VariantCardTheme>(
    defaultStyle: DefaultVariantCardStyle.new,
  );
}

extension VariantCardThemeExt on BuildContext {
  CardStyle get variantCardTheme => VariantCardTheme.of(this);
}

class DefaultVariantCardStyle extends InheritCardStyle {
  static const kBackground = Colors.white70;
  static const kForeground = Colors.black87;

  @override
  Color get background => kBackground;

  @override
  Color get foreground => kForeground;
}
