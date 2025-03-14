import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' show Card, InputBorder;
import 'package:flutter/widgets.dart';

import '../../../material_context_theme.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    super.key,
    bool? semanticContainer,
    this.child,
    StyleOfContext<CardStyle>? styleOf,
  })  : styleOf = styleOf ?? CardTheme.of,
        semanticContainer = semanticContainer ?? true;

  final bool semanticContainer;
  final Widget? child;
  final StyleOfContext<CardStyle> styleOf;

  @override
  Widget build(BuildContext context) {
    return context.cardStyle.decorator.apply(
      builder: (context) {
        final style = context.cardStyle;
        final child = this.child;
        var shape = style.shape;
        final side = style.side;
        if (side != null && shape != null) {
          if (shape is OutlinedBorder) {
            shape = shape.copyWith(side: style.side);
          } else if (shape is InputBorder) {
            shape = shape.copyWith(borderSide: style.side);
          }
        }
        return Card(
          color: style.color,
          shadowColor: style.shadowColor,
          surfaceTintColor: style.surfaceTintColor,
          elevation: style.elevation,
          shape: shape,
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
