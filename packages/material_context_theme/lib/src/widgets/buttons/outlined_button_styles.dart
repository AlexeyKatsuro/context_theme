import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:material_context_theme/src/material_states/material_state_scope.dart';
import 'package:material_context_theme/src/theme/colors_theme.dart';
import 'package:material_context_theme/src/widgets/buttons/text_button_styles.dart';

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
