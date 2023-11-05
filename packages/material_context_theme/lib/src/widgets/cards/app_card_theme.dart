import 'package:context_theme/context_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:material_context_theme/src/theme/colors_theme.dart';

class CardTheme extends WidgetTheme<CardStyle> {
  const CardTheme({
    super.key,
    super.child,
    required super.style,
  });

  static CardStyle of(BuildContext context, [StyleOwnerContext? parent]) {
    return WidgetTheme.styleOf<CardStyle, CardTheme>(context, inheritFrom: parent);
  }
}

extension CardStyleExt on BuildContext {
  CardStyle get cardStyle => CardTheme.of(this);
}

class CardStyle extends Style {
  CardStyle get inherit => CardTheme.of(context, parent);

  CardStyle get link => CardTheme.of(context);

  Clip get clipBehavior => inherit.clipBehavior;

  Color? get color => inherit.color;

  TextStyle get textStyle => inherit.textStyle;

  Color? get shadowColor => inherit.shadowColor;

  Color? get surfaceTintColor => inherit.surfaceTintColor;

  double? get elevation => inherit.elevation;

  ShapeBorder? get shape => inherit.shape;

  bool get borderOnForeground => inherit.borderOnForeground;

  EdgeInsetsGeometry get margin => inherit.margin;
}

class BaseCardStyle extends CardStyle {
  @override
  Clip get clipBehavior => Clip.none;

  @override
  Color get color => context.colorScheme.surface;

  @override
  TextStyle get textStyle => DefaultTextStyle.of(context).style.copyWith(
    color: context.colorScheme.onSurface
  );

  @override
  Color get shadowColor => context.colorScheme.shadow;

  @override
  Color get surfaceTintColor => context.colorScheme.surfaceTint;

  @override
  double get elevation => 1.0;

  @override
  ShapeBorder get shape =>
      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0)));

  @override
  EdgeInsetsGeometry get margin => const EdgeInsets.all(4.0);

  @override
  bool get borderOnForeground => true;
}
