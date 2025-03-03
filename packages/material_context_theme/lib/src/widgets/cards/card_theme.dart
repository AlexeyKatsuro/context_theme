import 'package:context_theme/context_theme.dart';
import 'package:flutter/widgets.dart';

import '../../theme/colors_theme.dart';
import '../decorator/index.dart';

class CardTheme extends ContextTheme<CardStyle, CardTheme> {
  const CardTheme({
    super.key,
    super.child,
    required super.style,
  });

  static const of = StyleOf<CardStyle, CardTheme>(
    defaultStyle: DefaultCardStyle.new,
  );
}

extension CardStyleExt on BuildContext {
  CardStyle get cardStyle => CardTheme.of(this);
}

abstract class CardStyle extends Style with TypedStyle<CardStyle> {
  Clip get clipBehavior;

  Color? get color;

  TextStyle get textStyle;

  IconThemeData? get iconTheme;

  Color? get shadowColor;

  Color? get surfaceTintColor;

  double? get elevation;

  ShapeBorder? get shape;

  BorderSide? get side;

  bool get borderOnForeground;

  EdgeInsetsGeometry get margin;

  EdgeInsetsGeometry get padding;

  DecorateWrapper? get decorator;
}

class InheritCardStyle = CardStyle with InheritStyle, InheritCardStyleMixin;
mixin InheritCardStyleMixin on CardStyle {
  @override
  StyleOfContext<CardStyle> get inheritFrom => CardTheme.of;

  @override
  Clip get clipBehavior => inherit.clipBehavior;

  @override
  Color? get color => inherit.color;

  @override
  TextStyle get textStyle => inherit.textStyle;

  @override
  IconThemeData? get iconTheme => inherit.iconTheme;

  @override
  Color? get shadowColor => inherit.shadowColor;

  @override
  Color? get surfaceTintColor => inherit.surfaceTintColor;

  @override
  double? get elevation => inherit.elevation;

  @override
  ShapeBorder? get shape => inherit.shape;

  @override
  bool get borderOnForeground => inherit.borderOnForeground;

  @override
  EdgeInsetsGeometry get margin => inherit.margin;

  @override
  EdgeInsetsGeometry get padding => inherit.padding;

  @override
  DecorateWrapper? get decorator => inherit.decorator;

  @override
  BorderSide? get side => inherit.side;
}

class DefaultCardStyle extends CardStyle {
  @override
  Clip get clipBehavior => Clip.none;

  @override
  Color get color => context.colorScheme.surface;

  @override
  TextStyle get textStyle =>
      DefaultTextStyle.of(context).style.copyWith(color: context.colorScheme.onSurface);

  @override
  IconThemeData? get iconTheme => null;

  @override
  Color get shadowColor => context.colorScheme.shadow;

  @override
  Color get surfaceTintColor => context.colorScheme.surfaceTint;

  @override
  double get elevation => 1;

  @override
  ShapeBorder get shape =>
      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)));

  @override
  EdgeInsetsGeometry get margin => const EdgeInsets.all(4);

  @override
  EdgeInsetsGeometry get padding => EdgeInsets.zero;

  @override
  bool get borderOnForeground => true;

  @override
  DecorateWrapper? get decorator => null;

  @override
  BorderSide? get side => null;
}
