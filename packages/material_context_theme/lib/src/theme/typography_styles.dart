import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart';

class TypographyTheme extends ContextTheme<TypographyStyle, TypographyTheme> {
  const TypographyTheme({
    super.key,
    super.child,
    required super.style,
  });

  static const of = StyleOf<TypographyStyle, TypographyTheme>(
    defaultStyle: MaterialTypographyStyle.new,
  );
}

extension TypographyStyleExt on BuildContext {
  TypographyStyle get textTheme => TypographyTheme.of(this);
}

abstract class TypographyStyle extends Style with TypedStyle<TypographyStyle> {
  TextStyle get displayLarge;

  TextStyle get displayMedium;

  TextStyle get displaySmall;

  TextStyle get headlineLarge;

  TextStyle get headlineMedium;

  TextStyle get headlineSmall;

  TextStyle get titleLarge;

  TextStyle get titleMedium;

  TextStyle get titleSmall;

  TextStyle get bodyLarge;

  TextStyle get bodyMedium;

  TextStyle get bodySmall;

  TextStyle get labelLarge;

  TextStyle get labelMedium;

  TextStyle get labelSmall;
}

class InheritTypographyStyle = TypographyStyle with InheritStyle, InheritTypographyStyleMixin;
mixin InheritTypographyStyleMixin on TypographyStyle {
  @override
  StyleOfContext<TypographyStyle> get inheritFrom => TypographyTheme.of;

  @override
  TextStyle get displayLarge => inherit.displayLarge;

  @override
  TextStyle get displayMedium => inherit.displayMedium;

  @override
  TextStyle get displaySmall => inherit.displaySmall;

  @override
  TextStyle get headlineLarge => inherit.headlineLarge;

  @override
  TextStyle get headlineMedium => inherit.headlineMedium;

  @override
  TextStyle get headlineSmall => inherit.headlineSmall;

  @override
  TextStyle get titleLarge => inherit.titleLarge;

  @override
  TextStyle get titleMedium => inherit.titleMedium;

  @override
  TextStyle get titleSmall => inherit.titleSmall;

  @override
  TextStyle get bodyLarge => inherit.bodyLarge;

  @override
  TextStyle get bodyMedium => inherit.bodyMedium;

  @override
  TextStyle get bodySmall => inherit.bodySmall;

  @override
  TextStyle get labelLarge => inherit.labelLarge;

  @override
  TextStyle get labelMedium => inherit.labelMedium;

  @override
  TextStyle get labelSmall => inherit.labelSmall;
}

class MaterialTypographyStyle extends TypographyStyle {
  @protected
  late final materialTextTheme = Theme.of(context).textTheme;

  @override
  late TextStyle displayLarge = materialTextTheme.displayLarge.makeInheritable();

  @override
  late TextStyle displayMedium = materialTextTheme.displayMedium.makeInheritable();

  @override
  late TextStyle displaySmall = materialTextTheme.displaySmall.makeInheritable();

  @override
  late TextStyle headlineLarge = materialTextTheme.headlineLarge.makeInheritable();

  @override
  late TextStyle headlineMedium = materialTextTheme.headlineMedium.makeInheritable();

  @override
  late TextStyle headlineSmall = materialTextTheme.headlineSmall.makeInheritable();

  @override
  late TextStyle titleLarge = materialTextTheme.titleLarge.makeInheritable();

  @override
  late TextStyle titleMedium = materialTextTheme.titleMedium.makeInheritable();

  @override
  late TextStyle titleSmall = materialTextTheme.titleSmall.makeInheritable();

  @override
  late TextStyle bodyLarge = materialTextTheme.bodyLarge.makeInheritable();

  @override
  late TextStyle bodyMedium = materialTextTheme.bodyMedium.makeInheritable();

  @override
  late TextStyle bodySmall = materialTextTheme.bodySmall.makeInheritable();

  @override
  late TextStyle labelLarge = materialTextTheme.labelLarge.makeInheritable();

  @override
  late TextStyle labelMedium = materialTextTheme.labelMedium.makeInheritable();

  @override
  late TextStyle labelSmall = materialTextTheme.labelSmall.makeInheritable();
}

extension on TextStyle? {
  TextStyle makeInheritable() {
    return TextStyle(
      inherit: true,
      fontSize: this?.fontSize,
      fontWeight: this?.fontWeight,
      fontStyle: this?.fontStyle,
      letterSpacing: this?.letterSpacing,
      wordSpacing: this?.wordSpacing,
      textBaseline: this?.textBaseline,
      height: this?.height,
      leadingDistribution: this?.leadingDistribution,
      locale: this?.locale,
      foreground: this?.foreground,
      background: this?.background,
      shadows: this?.shadows,
      fontFeatures: this?.fontFeatures,
      fontVariations: this?.fontVariations,
      decoration: this?.decoration,
      decorationColor: this?.decorationColor,
      decorationStyle: this?.decorationStyle,
      decorationThickness: this?.decorationThickness,
      debugLabel: this?.debugLabel,
      overflow: this?.overflow,
      fontFamily: this?.fontFamily,
    );
  }
}
