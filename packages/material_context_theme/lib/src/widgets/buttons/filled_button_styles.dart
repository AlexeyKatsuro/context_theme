import 'package:flutter/material.dart' hide ButtonStyle, MaterialStateColor;
import 'package:material_context_theme/src/material_states/material_state_scope.dart';
import 'package:material_context_theme/src/theme/colors_theme.dart';

import 'base_styles.dart';

class FilledButtonStyle extends ButtonStyle {

  @override
  Color? get backgroundColor {
    if (context.isDisabled) {
      return context.colorScheme.onSurface.withOpacity(0.12);
    }
    return link.primaryColor;
  }

  @override
  Color get overlayColor => OverlayMaterialStateColor(link.onPrimaryColor);

  @override
  Color? get foregroundColor {
    if (context.isDisabled) {
      return context.colorScheme.onSurface.withOpacity(0.38);
    }
    return link.onPrimaryColor;
  }

  @override
  double get elevation {
    if (context.isDisabled) {
      return 0.0;
    }
    if (context.isHovered) {
      return 1.0;
    }
    if (context.isFocused) {
      return 0.0;
    }
    if (context.isPressed) {
      return 0.0;
    }
    return 0.0;
  }

}



