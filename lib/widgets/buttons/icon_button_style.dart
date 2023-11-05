import 'package:attr_theme/utils/material_states/material_state_scope.dart';
import 'package:attr_theme/widgets/buttons/text_button_styles.dart';
import 'package:attr_theme/widgets/styles/colors/colors_theme.dart';
import 'package:flutter/material.dart';

import 'base_styles.dart';

class IconButtonStyle extends TextButtonStyle {
  @override
  Color get foregroundColor {
    if (context.isDisabled) {
      return context.colorScheme.onSurface.withOpacity(0.38);
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
  EdgeInsetsGeometry get padding => const EdgeInsets.all(8.0);

  @override
  Size get minimumSize => const Size(40.0, 40.0);
}
