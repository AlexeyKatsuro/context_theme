import 'package:context_theme/context_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:material_context_theme/material_context_theme.dart';

class IconButtonTheme extends ContextTheme<ButtonStyle, IconButtonTheme> {
  const IconButtonTheme({
    super.key,
    super.child,
    required super.style,
  }) : super(styleOf: of);

  static ButtonStyle of(BuildContext context, [StyleOwnerContext? parent]) {
    return ContextTheme.styleOf<ButtonStyle, IconButtonTheme>(
      context,
      inheritFrom: parent,
      defaultStyle: DefaultIconButton.new,
    );
  }
}

extension IconButtonThemeExt on BuildContext {
  ButtonStyle get iconButtonTheme => IconButtonTheme.of(this);
}

class DefaultIconButton extends InheritButtonStyle {
  @override
  ButtonStyle get inherit => context.buttonStyle;

  @override
  OutlinedBorder get shape => const RoundedRectangleBorder();
}
