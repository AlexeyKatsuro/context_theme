import 'package:context_theme/context_theme.dart';
import 'package:flutter/widgets.dart';

import 'card_theme.dart';

class ExtendedCardTheme extends ContextTheme<ExtendedCardStyle, ExtendedCardTheme> {
  const ExtendedCardTheme({
    super.key,
    super.child,
    required super.style,
  });

  static const of = StyleOf<ExtendedCardStyle, ExtendedCardTheme>(
    defaultStyle: DefaultExtendedCardStyle.new,
  );
}

extension ExtendedCardThemeExt on BuildContext {
  ExtendedCardStyle get extendedCardTheme => ExtendedCardTheme.of(this);
}

abstract class ExtendedCardStyle extends CardStyle {
  @override
  ExtendedCardStyle get link => super.link as ExtendedCardStyle;

  @override
  ExtendedCardStyle get inherit => super.inherit as ExtendedCardStyle;

  OutlinedBorder get shape;
}

class InheritExtendedCardStyle = ExtendedCardStyle
    with InheritCardStyleMixin, InheritExtendedCardStyleMixin;
mixin InheritExtendedCardStyleMixin on ExtendedCardStyle {
  @override
  final inheritFrom = ExtendedCardTheme.of;

  @override
  OutlinedBorder get shape => inherit.shape;
}

class DefaultExtendedCardStyle extends ExtendedCardStyle with InheritCardStyleMixin {
  @override
  OutlinedBorder get shape => RoundedRectangleBorder(side: BorderSide(color: link.foreground));
}
