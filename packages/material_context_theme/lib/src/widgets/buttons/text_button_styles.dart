import 'package:flutter/material.dart' hide ButtonStyle;
import '../../material_states/material_state_scope.dart';
import '../../theme/colors_theme.dart';

import 'base_styles.dart';

class TextButtonStyle extends InheritButtonStyle {
  @override
  Color get backgroundColor => Colors.transparent;

  @override
  Color get foregroundColor {
    if (context.isDisabled) {
      return context.colorScheme.onSurface.withValues(alpha: 0.38);
    }
    return link.primaryColor;
  }

  @override
  Color get overlayColor => OverlayMaterialStateColor(link.primaryColor);

  @override
  Color get shadowColor => Colors.transparent;

  @override
  double get elevation => 0;

  @override
  EdgeInsetsGeometry get padding => scaledTextPadding(context);
}

EdgeInsetsGeometry scaledTextPadding(BuildContext context) {
  final useMaterial3 = Theme.of(context).useMaterial3;
  return ButtonStyleButton.scaledPadding(
    useMaterial3
        ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
        : const EdgeInsets.all(8),
    const EdgeInsets.symmetric(horizontal: 8),
    const EdgeInsets.symmetric(horizontal: 4),
    // ignore: deprecated_member_use
    MediaQuery.textScalerOf(context).textScaleFactor,
  );
}
