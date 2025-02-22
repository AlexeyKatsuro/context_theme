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

  BorderSide get side;

  OutlinedBorder get shape;
}

class InheritExtendedCardStyle = ExtendedCardStyle
    with InheritCardStyleMixin, InheritExtendedCardStyleMixin;
mixin InheritExtendedCardStyleMixin on ExtendedCardStyle {
  @override
  StyleOfContext<ExtendedCardStyle> get inheritFrom => ExtendedCardTheme.of;

  @override
  ExtendedCardStyle get inherit => super.inherit as ExtendedCardStyle;

  @override
  OutlinedBorder get shape => inherit.shape;

  @override
  BorderSide get side => inherit.side;
}

class DefaultExtendedCardStyle extends ExtendedCardStyle with InheritCardStyleMixin {
  @override
  OutlinedBorder get shape => RoundedRectangleBorder(side: link.side);

  @override
  BorderSide get side => BorderSide(color: link.foreground);
}

class RedBackgroundExtendedCardStyle = InheritExtendedCardStyle with RedBackgroundCardStyleMixin;

class StadiumCard = InheritExtendedCardStyle with StadiumCardStyleMixin;
mixin StadiumCardStyleMixin on ExtendedCardStyle {
  @override
  OutlinedBorder get shape => StadiumBorder(side: link.side);
}
