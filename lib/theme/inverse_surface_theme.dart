import 'package:attr_theme/attributes/core/attrs.dart';
import 'package:attr_theme/theme/surface_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'attr_theme.dart';
import 'attribute.dart';

class InverseSurfaceTheme extends AttrTheme {
 const InverseSurfaceTheme({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static SurfaceThemeGetter of(BuildContext context) {
    throw '';
  }

  @override
  Iterable<Attribute> buildAttributes(BuildContext context) {
    final theme = SurfaceTheme.of(context);
    return [
      AttributeRef(name: Attrs.background, ref: theme.foreground),
      AttributeRef(name: Attrs.foreground, ref: theme.background),
    ];
  }
}
