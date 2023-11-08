import 'package:flutter/material.dart' hide ButtonStyle;
import '../../material_states/material_state_scope.dart';
import '../../theme/colors_theme.dart';
import 'text_button_styles.dart';

class OutlinedButtonStyle extends TextButtonStyle {

  @override
  EdgeInsetsGeometry get padding => inherit.padding; // Take default padding, not from TextButtonStyle

  @override
  BorderSide get side {
    if (context.isDisabled) {
      return BorderSide(color: context.colorScheme.onSurface.withOpacity(0.12));
    }
    return BorderSide(color: context.colorScheme.outline);
  }
}
