import 'package:flutter/material.dart';
import 'package:context_theme/context_theme.dart';

class ColorsTheme extends WidgetTheme<ColorsStyle> {
  const ColorsTheme({
    super.key,
    required super.style,
    super.child,
  });

  static ColorsStyle of(BuildContext context, [StyleOwnerContext? parent]) {
    return WidgetTheme.styleOf<ColorsStyle, ColorsTheme>(
      context,
      inheritFrom: parent,
      defaultStyle: MaterialColorsStyle.new,
    );
  }
}

extension ColorsThemeExt on BuildContext {
  ColorsStyle get colorScheme => ColorsTheme.of(this);
}

class ColorsStyle extends Style {
  @protected
  ColorsStyle get inherit => ColorsTheme.of(context, parent);

  @protected
  ColorsStyle get link => ColorsTheme.of(context);

  Brightness get brightness => inherit.brightness;

  Color get primary => inherit.primary;

  Color get onPrimary => inherit.onPrimary;

  Color get primaryContainer => inherit.primaryContainer;

  Color get onPrimaryContainer => inherit.onPrimaryContainer;

  Color get secondary => inherit.secondary;

  Color get onSecondary => inherit.onSecondary;

  Color get secondaryContainer => inherit.secondaryContainer;

  Color get onSecondaryContainer => inherit.onSecondaryContainer;

  Color get tertiary => inherit.tertiary;

  Color get onTertiary => inherit.onTertiary;

  Color get tertiaryContainer => inherit.tertiaryContainer;

  Color get onTertiaryContainer => inherit.onTertiaryContainer;

  Color get error => inherit.error;

  Color get onError => inherit.onError;

  Color get errorContainer => inherit.errorContainer;

  Color get onErrorContainer => inherit.onErrorContainer;

  Color get background => inherit.background;

  Color get onBackground => inherit.onBackground;

  Color get surface => inherit.surface;

  Color get onSurface => inherit.onSurface;

  Color get surfaceVariant => inherit.surfaceVariant;

  Color get onSurfaceVariant => inherit.onSurfaceVariant;

  Color get outline => inherit.outline;

  Color get outlineVariant => inherit.outlineVariant;

  Color get shadow => inherit.shadow;

  Color get scrim => inherit.scrim;

  Color get inverseSurface => inherit.inverseSurface;

  Color get onInverseSurface => inherit.onInverseSurface;

  Color get inversePrimary => inherit.inversePrimary;

  Color get surfaceTint => inherit.surfaceTint;
}

class BaseColorsStyle extends ColorsStyle {
  @override
  Color get primaryContainer => link.primary;

  @override
  Color get onPrimaryContainer => link.onPrimary;

  @override
  Color get secondaryContainer => link.secondary;

  @override
  Color get onSecondaryContainer => link.onSecondary;

  @override
  Color get tertiary => link.secondary;

  @override
  Color get onTertiary => link.onSecondary;

  @override
  Color get tertiaryContainer => link.tertiary;

  @override
  Color get onTertiaryContainer => link.onTertiary;

  @override
  Color get errorContainer => link.error;

  @override
  Color get onErrorContainer => link.onError;

  @override
  Color get surfaceVariant => link.surface;

  @override
  Color get onSurfaceVariant => link.onSurface;

  @override
  Color get outline => link.onBackground;

  @override
  Color get outlineVariant => link.onBackground;

  @override
  Color get shadow => const Color(0xff000000);

  @override
  Color get scrim => const Color(0xff000000);

  @override
  Color get inverseSurface => link.onSurface;

  @override
  Color get onInverseSurface => link.surface;

  @override
  Color get inversePrimary => link.onPrimary;

  @override
  Color get surfaceTint => link.primary;
}

class MaterialColorsStyle extends BaseColorsStyle {
  ColorScheme get materialScheme => Theme.of(context).colorScheme;

  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get primary => materialScheme.primary;

  @override
  Color get onPrimary => materialScheme.onPrimary;

  @override
  Color get primaryContainer => materialScheme.primaryContainer;

  @override
  Color get onPrimaryContainer => materialScheme.onPrimaryContainer;

  @override
  Color get secondary => materialScheme.secondary;

  @override
  Color get onSecondary => materialScheme.onSecondary;

  @override
  Color get secondaryContainer => materialScheme.secondaryContainer;

  @override
  Color get onSecondaryContainer => materialScheme.onSecondaryContainer;

  @override
  Color get tertiary => materialScheme.tertiary;

  @override
  Color get onTertiary => materialScheme.onTertiary;

  @override
  Color get tertiaryContainer => materialScheme.tertiaryContainer;

  @override
  Color get onTertiaryContainer => materialScheme.onTertiaryContainer;

  @override
  Color get error => materialScheme.error;

  @override
  Color get onError => materialScheme.onError;

  @override
  Color get errorContainer => materialScheme.errorContainer;

  @override
  Color get onErrorContainer => materialScheme.onErrorContainer;

  @override
  Color get background => materialScheme.background;

  @override
  Color get onBackground => materialScheme.onBackground;

  @override
  Color get surface => materialScheme.surface;

  @override
  Color get onSurface => materialScheme.onSurface;

  @override
  Color get surfaceVariant => materialScheme.surfaceVariant;

  @override
  Color get onSurfaceVariant => materialScheme.onSurfaceVariant;

  @override
  Color get shadow => materialScheme.shadow;

  @override
  Color get scrim => materialScheme.scrim;

  @override
  Color get inverseSurface => materialScheme.inverseSurface;

  @override
  Color get onInverseSurface => materialScheme.onInverseSurface;

  @override
  Color get inversePrimary => materialScheme.inversePrimary;
}

class LightColorsStyle extends BaseColorsStyle {
  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get primary => const Color(0xFF6750A4);

  @override
  Color get onPrimary => const Color(0xFFFFFFFF);

  @override
  Color get primaryContainer => const Color(0xFFEADDFF);

  @override
  Color get onPrimaryContainer => const Color(0xFF21005D);

  @override
  Color get secondary => const Color(0xFF625B71);

  @override
  Color get onSecondary => const Color(0xFFFFFFFF);

  @override
  Color get secondaryContainer => const Color(0xFFE8DEF8);

  @override
  Color get onSecondaryContainer => const Color(0xFF1D192B);

  @override
  Color get tertiary => const Color(0xFF7D5260);

  @override
  Color get onTertiary => const Color(0xFFFFFFFF);

  @override
  Color get tertiaryContainer => const Color(0xFFFFD8E4);

  @override
  Color get onTertiaryContainer => const Color(0xFF31111D);

  @override
  Color get error => const Color(0xFFB3261E);

  @override
  Color get onError => const Color(0xFFFFFFFF);

  @override
  Color get errorContainer => const Color(0xFFF9DEDC);

  @override
  Color get onErrorContainer => const Color(0xFF410E0B);

  @override
  Color get background => const Color(0xFFFFFBFE);

  @override
  Color get onBackground => const Color(0xFF1C1B1F);

  @override
  Color get surface => const Color(0xFFFFFBFE);

  @override
  Color get onSurface => const Color(0xFF1C1B1F);

  @override
  Color get surfaceVariant => const Color(0xFFE7E0EC);

  @override
  Color get onSurfaceVariant => const Color(0xFF49454F);

  @override
  Color get shadow => const Color(0xFF000000);

  @override
  Color get scrim => const Color(0xFF000000);

  @override
  Color get inverseSurface => const Color(0xFF313033);

  @override
  Color get onInverseSurface => const Color(0xFFF4EFF4);

  @override
  Color get inversePrimary => const Color(0xFFD0BCFF);
}

class DarkColorsStyle extends BaseColorsStyle {
  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get primary => const Color(0xFFD0BCFF);

  @override
  Color get onPrimary => const Color(0xFF381E72);

  @override
  Color get primaryContainer => const Color(0xFF4F378B);

  @override
  Color get onPrimaryContainer => const Color(0xFFEADDFF);

  @override
  Color get secondary => const Color(0xFFCCC2DC);

  @override
  Color get onSecondary => const Color(0xFF332D41);

  @override
  Color get secondaryContainer => const Color(0xFF4A4458);

  @override
  Color get onSecondaryContainer => const Color(0xFFE8DEF8);

  @override
  Color get tertiary => const Color(0xFFEFB8C8);

  @override
  Color get onTertiary => const Color(0xFF492532);

  @override
  Color get tertiaryContainer => const Color(0xFF633B48);

  @override
  Color get onTertiaryContainer => const Color(0xFFFFD8E4);

  @override
  Color get error => const Color(0xFFF2B8B5);

  @override
  Color get onError => const Color(0xFF601410);

  @override
  Color get errorContainer => const Color(0xFF8C1D18);

  @override
  Color get onErrorContainer => const Color(0xFFF9DEDC);

  @override
  Color get background => const Color(0xFF1C1B1F);

  @override
  Color get onBackground => const Color(0xFFE6E1E5);

  @override
  Color get surface => const Color(0xFF1C1B1F);

  @override
  Color get onSurface => const Color(0xFFE6E1E5);

  @override
  Color get surfaceVariant => const Color(0xFF49454F);

  @override
  Color get onSurfaceVariant => const Color(0xFFCAC4D0);

  @override
  Color get inverseSurface => const Color(0xFFE6E1E5);

  @override
  Color get onInverseSurface => const Color(0xFF313033);

  @override
  Color get inversePrimary => const Color(0xFF6750A4);
}
