import 'package:attr_theme/utils/material_states/material_state_properties.dart';
import 'package:attr_theme/utils/material_states/material_state_scope.dart';
import 'package:attr_theme/widgets/styles/colors/colors_theme.dart';
import 'package:flutter/material.dart' hide ButtonStyle, MaterialStateColor;

import 'base_styles.dart';

class FilledButtonStyle extends ButtonStyle {

  @override
  Color get primaryColor => context.colorScheme.primary;

  @override
  Color get onPrimaryColor => context.colorScheme.onPrimary;

  @override
  Color? get backgroundColor {
    if (context.isDisabled) {
      return context.colorScheme.onSurface.withOpacity(0.12);
    }
    return link.primaryColor;
  }

  @override
  Color? get overlayColor {
    if (context.isPressed) {
      return link.onPrimaryColor.withOpacity(0.12);
    }
    if (context.isHovered) {
      return link.onPrimaryColor.withOpacity(0.08);
    }
    if (context.isFocused) {
      return link.onPrimaryColor.withOpacity(0.12);
    }
    return null;
  }

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

  @override
  EdgeInsetsGeometry get padding => _scaledPadding(context);

}

EdgeInsetsGeometry _scaledPadding(BuildContext context) {
  final bool useMaterial3 = Theme.of(context).useMaterial3;
  final double padding1x = useMaterial3 ? 24.0 : 16.0;
  return ButtonStyleButton.scaledPadding(
    EdgeInsets.symmetric(horizontal: padding1x),
    EdgeInsets.symmetric(horizontal: padding1x / 2),
    EdgeInsets.symmetric(horizontal: padding1x / 2 / 2),
    MediaQuery.textScaleFactorOf(context),
  );
}

