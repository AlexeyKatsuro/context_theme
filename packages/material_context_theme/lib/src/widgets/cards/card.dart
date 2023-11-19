import 'package:flutter/material.dart' show Card;
import 'package:flutter/widgets.dart';

import '../decorator/index.dart';
import 'card_theme.dart';

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
    return context.cardStyle.decorator.apply(
      builder: (context) {
        final style = context.cardStyle;
        final child = this.child;
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
              ? DefaultTextStyle.merge(
                  style: style.textStyle,
                  child: IconTheme(
                    data: IconTheme.of(context).merge(style.iconTheme),
                    child: Padding(
                      padding: style.padding,
                      child: child,
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
