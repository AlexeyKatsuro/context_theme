import 'package:attr_theme/utils/material_states/material_state_scope.dart';
import 'package:attr_theme/widgets/styles/colors/colors_theme.dart';
import 'package:flutter/material.dart' hide ButtonStyle;

import 'base_styles.dart';

class OutlinedButtonStyle extends ButtonStyle {
  @override
  Color? get backgroundColor => Colors.transparent;

  @override
  Color get foregroundColor {
    if (context.isDisabled) {
      return context.colorScheme.onSurface.withOpacity(0.38);
    }
    return link.primaryColor;
  }

  @override
  Color? get overlayColor => OverlayMaterialStateColor(link.primaryColor);

  @override
  Color get shadowColor => Colors.transparent;

  @override
  double get elevation => 0.0;

  @override
  BorderSide? get side {
    if (context.isDisabled) {
      return BorderSide(color: context.colorScheme.onSurface.withOpacity(0.12));
    }
    return BorderSide(color: context.colorScheme.outline);
  }
}
