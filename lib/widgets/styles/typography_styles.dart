import 'package:attr_theme/widgets/styles/colors/colors_theme.dart';
import 'package:attr_theme/widgets/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TypographyTheme extends WidgetTheme<TypographyStyle> {
  const TypographyTheme({
    super.key,
    super.child,
    required super.style,
  });

  static TypographyStyle of(BuildContext context, [StyleOwnerContext? parent]) {
    return WidgetTheme.styleOf<TypographyStyle, TypographyTheme>(context, inheritFrom: parent);
  }
}

extension TypographyStyleExt on BuildContext {
  TypographyStyle get textTheme => TypographyTheme.of(this);
}

class TypographyStyle extends Style {
  TypographyStyle get inherit => TypographyTheme.of(context, parent);

  TypographyStyle get link => TypographyTheme.of(context);

  TextStyle get displayLarge => inherit.displayLarge;

  TextStyle get displayMedium => inherit.displayMedium;

  TextStyle get displaySmall => inherit.displaySmall;

  TextStyle get headlineLarge => inherit.headlineLarge;

  TextStyle get headlineMedium => inherit.headlineMedium;

  TextStyle get headlineSmall => inherit.headlineSmall;

  TextStyle get titleLarge => inherit.titleLarge;

  TextStyle get titleMedium => inherit.titleMedium;

  TextStyle get titleSmall => inherit.titleSmall;

  TextStyle get bodyLarge => inherit.bodyLarge;

  TextStyle get bodyMedium => inherit.bodyMedium;

  TextStyle get bodySmall => inherit.bodySmall;

  TextStyle get labelLarge => inherit.labelLarge;

  TextStyle get labelMedium => inherit.labelMedium;

  TextStyle get labelSmall => inherit.labelSmall;
}

class BaseTypographyStyle extends Style {
  TypographyStyle get inherit => TypographyTheme.of(context, parent);

  TypographyStyle get link => TypographyTheme.of(context);

  TextStyle get displayLarge => inherit.displayLarge;

  TextStyle get displayMedium => inherit.displayMedium;

  TextStyle get displaySmall => inherit.displaySmall;

  TextStyle get headlineLarge => inherit.headlineLarge;

  TextStyle get headlineMedium => inherit.headlineMedium;

  TextStyle get headlineSmall => inherit.headlineSmall;

  TextStyle get titleLarge => inherit.titleLarge;

  TextStyle get titleMedium => inherit.titleMedium;

  TextStyle get titleSmall => inherit.titleSmall;

  TextStyle get bodyLarge => inherit.bodyLarge;

  TextStyle get bodyMedium => inherit.bodyMedium;

  TextStyle get bodySmall => inherit.bodySmall;

  TextStyle get labelLarge => inherit.labelLarge;

  TextStyle get labelMedium => inherit.labelMedium;

  TextStyle get labelSmall => inherit.labelSmall;
}

class MaterialTypographyStyle extends TypographyStyle {
  @protected
  TextTheme get materialTextTheme => Theme.of(context).textTheme;
  @override
  TextStyle get displayLarge => materialTextTheme.displayLarge.makeInheritable();
  @override
  TextStyle get displayMedium => materialTextTheme.displayMedium.makeInheritable();
  @override
  TextStyle get displaySmall => materialTextTheme.displaySmall.makeInheritable();
  @override
  TextStyle get headlineLarge => materialTextTheme.headlineLarge.makeInheritable();
  @override
  TextStyle get headlineMedium => materialTextTheme.headlineMedium.makeInheritable();
  @override
  TextStyle get headlineSmall => materialTextTheme.headlineSmall.makeInheritable();
  @override
  TextStyle get titleLarge => materialTextTheme.titleLarge.makeInheritable();
  @override
  TextStyle get titleMedium => materialTextTheme.titleMedium.makeInheritable();
  @override
  TextStyle get titleSmall => materialTextTheme.titleSmall.makeInheritable();
  @override
  TextStyle get bodyLarge => materialTextTheme.bodyLarge.makeInheritable();
  @override
  TextStyle get bodyMedium => materialTextTheme.bodyMedium.makeInheritable();
  @override
  TextStyle get bodySmall => materialTextTheme.bodySmall.makeInheritable();
  @override
  TextStyle get labelLarge => materialTextTheme.labelLarge.makeInheritable();
  @override
  TextStyle get labelMedium => materialTextTheme.labelMedium.makeInheritable();
  @override
  TextStyle get labelSmall => materialTextTheme.labelSmall.makeInheritable();
}


extension on TextStyle? {
  TextStyle makeInheritable() {
    return TextStyle(
        inherit: true,
        color: null,
        backgroundColor: null,
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
