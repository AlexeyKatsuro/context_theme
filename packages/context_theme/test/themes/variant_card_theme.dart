import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart';

import 'card_theme.dart';

class VariantCardTheme extends ContextTheme<CardStyle, VariantCardTheme> {
  const VariantCardTheme({
    super.key,
    super.child,
    required super.style,
  }) : super(styleOf: of);

  static CardStyle of(BuildContext context, [StyleOwnerContext? parent]) {
    return ContextTheme.styleOf<CardStyle, VariantCardTheme>(
      context,
      inheritFrom: parent,
      defaultStyle: DefaultVariantCardStyle.new,
    );
  }
}

extension VariantCardThemeExt on BuildContext {
  CardStyle get variantCardTheme => VariantCardTheme.of(this);
}

class DefaultVariantCardStyle extends InheritCardStyle {
  @override
  CardStyle get inherit => context.cardTheme;

  @override
  Color get background => Colors.white70;

  @override
  Color get foreground => Colors.black87;
}
