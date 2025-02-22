import 'package:context_theme/context_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:material_context_theme/material_context_theme.dart';

class IconButtonTheme extends ContextTheme<ButtonStyle, IconButtonTheme> {
  const IconButtonTheme({
    super.key,
    super.child,
    required super.style,
  });

  static const of = StyleOf<ButtonStyle, IconButtonTheme>(
    defaultStyle: DefaultIconButton.new,
  );
}

extension IconButtonThemeExt on BuildContext {
  ButtonStyle get iconButtonTheme => IconButtonTheme.of(this);
}

class DefaultIconButton extends InheritButtonStyle {
  @override
  OutlinedBorder get shape => const RoundedRectangleBorder();
}
