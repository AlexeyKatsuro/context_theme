import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:material_context_theme/src/material_states/material_state_scope.dart';
import 'package:material_context_theme/src/theme/colors_theme.dart';

import 'base_styles.dart';

class TextButtonStyle extends ButtonStyle {

  @override
  Color get backgroundColor => Colors.transparent;

  @override
  Color get foregroundColor {
    if (context.isDisabled) {
      return context.colorScheme.onSurface.withOpacity(0.38);
    }
    return link.primaryColor;
  }

  @override
  Color get overlayColor => OverlayMaterialStateColor(link.primaryColor);

  @override
  Color get shadowColor => Colors.transparent;

  @override
  double get elevation => 0.0;

  @override
  EdgeInsetsGeometry get padding => scaledTextPadding(context);


}

EdgeInsetsGeometry scaledTextPadding(BuildContext context) {
  final bool useMaterial3 = Theme.of(context).useMaterial3;
  return ButtonStyleButton.scaledPadding(
    useMaterial3 ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8) :  const EdgeInsets.all(8),
    const EdgeInsets.symmetric(horizontal: 8),
    const EdgeInsets.symmetric(horizontal: 4),
    MediaQuery.textScaleFactorOf(context),
  );
}
