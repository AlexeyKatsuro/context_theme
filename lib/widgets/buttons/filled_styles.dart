import 'package:flutter/material.dart';

class FilledButtonStyle  extends ButtonStyle {
  FilledButtonStyle(this.context)
      : super(
    animationDuration: kThemeChangeDuration,
    enableFeedback: true,
    alignment: Alignment.center,
  );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  MaterialStateProperty<Color?>? get backgroundColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.12);
        }
        return _colors.primary;
      });

  @override
  MaterialStateProperty<Color?>? get foregroundColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        return _colors.onPrimary;
      });

  @override
  MaterialStateProperty<Color?>? get overlayColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return _colors.onPrimary.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.onPrimary.withOpacity(0.12);
        }
        if (states.contains(MaterialState.pressed)) {
          return _colors.onPrimary.withOpacity(0.12);
        }
        return null;
      });

  @override
  MaterialStateProperty<Color>? get shadowColor =>
      MaterialStatePropertyAll<Color>(_colors.shadow);

  @override
  MaterialStateProperty<Color>? get surfaceTintColor =>
      const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialStateProperty<double>? get elevation =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return 0.0;
        }
        if (states.contains(MaterialState.hovered)) {
          return 1.0;
        }
        if (states.contains(MaterialState.focused)) {
          return 0.0;
        }
        if (states.contains(MaterialState.pressed)) {
          return 0.0;
        }
        return 0.0;
      });
}

