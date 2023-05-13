import 'package:flutter/material.dart';

class IconButtonStyle extends ButtonStyle {
  IconButtonStyle(this.context) : super();

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  // No default text style

  @override
  MaterialStateProperty<Color?>? get backgroundColor =>
      const MaterialStatePropertyAll<Color?>(Colors.transparent);

  @override
  MaterialStateProperty<Color?>? get foregroundColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return _colors.onSurface.withOpacity(0.38);
        }
        if (states.contains(MaterialState.selected)) {
          return _colors.primary;
        }
        return _colors.onSurface;
      });

  @override
  MaterialStateProperty<Color?>? get overlayColor =>
      MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          if (states.contains(MaterialState.hovered)) {
            return _colors.primary.withOpacity(0.08);
          }
          if (states.contains(MaterialState.focused)) {
            return _colors.primary.withOpacity(0.12);
          }
          if (states.contains(MaterialState.pressed)) {
            return _colors.primary.withOpacity(0.12);
          }
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.onSurfaceVariant.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.onSurfaceVariant.withOpacity(0.08);
        }
        if (states.contains(MaterialState.pressed)) {
          return _colors.onSurfaceVariant.withOpacity(0.12);
        }
        return null;
      });

  @override
  MaterialStateProperty<double>? get elevation => const MaterialStatePropertyAll<double>(0.0);

  @override
  MaterialStateProperty<Color>? get shadowColor =>
      const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialStateProperty<Color>? get surfaceTintColor =>
      const MaterialStatePropertyAll<Color>(Colors.transparent);

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding =>
      const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(8.0));

  @override
  MaterialStateProperty<Size>? get minimumSize =>
      const MaterialStatePropertyAll<Size>(Size(40.0, 40.0));

  // No default fixedSize

  @override
  MaterialStateProperty<Size>? get maximumSize =>
      const MaterialStatePropertyAll<Size>(Size.infinite);

  @override
  MaterialStateProperty<double>? get iconSize => const MaterialStatePropertyAll<double>(24.0);

  // No default side

  @override
  MaterialStateProperty<OutlinedBorder>? get shape =>
      const MaterialStatePropertyAll<OutlinedBorder>(StadiumBorder());
}
