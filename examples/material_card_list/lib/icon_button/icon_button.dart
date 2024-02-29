import 'package:material_card_list/icon_button/icon_button_theme.dart';
import 'package:material_context_theme/material_context_theme.dart';

class MaterialIconButton extends MaterialButton {
  const MaterialIconButton({
    super.key,
    super.clipBehavior,
    required super.onPressed,
    super.onLongPress,
    super.onFocusChange,
    super.onHover,
    super.focusNode,
    super.autofocus = false,
    super.enabled,
    required super.child,
  }) : super(styleOf: IconButtonTheme.of);
}
