import 'package:attr_theme/widgets/cards/app_card_theme.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    bool? semanticContainer,
    this.child,
  }) : semanticContainer = semanticContainer ?? true;

  /// Whether this widget represents a single semantic container, or if false
  /// a collection of individual semantic nodes.
  ///
  /// Defaults to true.
  ///
  /// Setting this flag to true will attempt to merge all child semantics into
  /// this node. Setting this flag to false will force all child semantic nodes
  /// to be explicit.
  ///
  /// This flag should be false if the card contains multiple different types
  /// of content.
  final bool semanticContainer;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
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
