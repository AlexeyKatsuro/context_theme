import 'package:flutter/material.dart';
import 'package:material_context_theme/src/widgets/cards/card_theme.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    super.key,
    bool? semanticContainer,
    this.child,
  }) : semanticContainer = semanticContainer ?? true;

  final bool semanticContainer;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final style = context.cardStyle;
    return Card(
      color: style.color,
      shadowColor: style.shadowColor,
      surfaceTintColor: style.surfaceTintColor,
      elevation: style.elevation,
      shape: style.shape,
      borderOnForeground: style.borderOnForeground,
      margin: style.margin,
      clipBehavior: style.clipBehavior,
      semanticContainer: semanticContainer,
      child: child != null
          ? DefaultTextStyle(
              style: style.textStyle,
              child: child!,
            )
          : null,
    );
  }
}
