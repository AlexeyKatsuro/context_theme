import 'package:attr_theme/utils/material_states/material_state_scope.dart';
import 'package:attr_theme/widgets/buttons/text_button_styles.dart';
import 'package:attr_theme/widgets/styles/colors/colors_theme.dart';
import 'package:flutter/material.dart' hide ButtonStyle;

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
