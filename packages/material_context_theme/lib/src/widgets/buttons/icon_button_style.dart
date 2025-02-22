import 'package:flutter/material.dart';
import '../../material_states/material_state_scope.dart';
import '../../theme/colors_theme.dart';

import 'base_styles.dart';
import 'text_button_styles.dart';

class IconButtonStyle extends TextButtonStyle {
  @override
  Color get foregroundColor {
    if (context.isDisabled) {
      return context.colorScheme.onSurface.withValues(alpha: 0.38);
    }
    if (context.isSelected) {
      return link.primaryColor;
    }
    return context.colorScheme.onSurfaceVariant;
  }

  @override
  Color get overlayColor => OverlayMaterialStateColor(
        context.isSelected ? link.primaryColor : context.colorScheme.onSurface,
      );

  @override
  EdgeInsetsGeometry get padding => const EdgeInsets.all(8);

  @override
  Size get minimumSize => const Size(40, 40);
}
