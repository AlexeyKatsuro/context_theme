
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'base_styles.dart';

class AppButton extends ButtonStyleButton {
  const AppButton({
    super.key,
    super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
    super.statesController,
    super.child,
  }) : super(style: null);

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    return const ButtonStyle();
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return AppButtonTheme.of(context);
  }
}

class AppButtonTheme extends InheritedTheme {
  const AppButtonTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final ButtonStyle data;

  static ButtonStyle of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppButtonTheme>();
    return theme?.data ?? BaseButtonStyles(context);
  }

  static Widget merge({required Widget child, required ButtonStyle? data}) {
    return Builder(
      builder: (BuildContext context) {
        return AppButtonTheme(
          data: AppButtonTheme.of(context).mergeTo(data),
          child: child,
        );
      },
    );
  }

  @override
  bool updateShouldNotify(AppButtonTheme oldWidget) => data != oldWidget.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return AppButtonTheme(data: data, child: child);
  }
}

extension on ButtonStyle  {
  ButtonStyle mergeTo(ButtonStyle? style) {
    return style?.merge(this) ?? this;
  }
}


