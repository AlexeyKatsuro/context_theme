import 'package:attr_theme/theme/surface_theme.dart';
import 'package:flutter/material.dart';

import '../attributes/core/attrs.dart';
import 'attr_theme.dart';
import 'attribute.dart';

class MaterialColorTheme extends SurfaceTheme {
  const MaterialColorTheme({
    Key? key,
    required Widget child,
    required this.primary,
    required this.background,
    required this.foreground,
  }) : super(key: key, child: child);

  final Color primary;
  final Color background;
  final Color foreground;

  static MaterialColorThemeGetter of(BuildContext context) {
    return throw '';
  }

  @override
  Iterable<Attribute> buildAttributes(BuildContext context) {
    return [
      const AttributeValueColor(name: Attrs.background, value: Colors.white),
      const AttributeValueColor(name: Attrs.foreground, value: Colors.black),
      const AttributeValueColor(name: Attrs.primary, value: Colors.blue),
    ];
  }
}

mixin MaterialColorThemeGetter on AttrThemeGetter {
  Attribute<Color> get background => get(Attrs.background);

  Attribute<Color> get foreground => get(Attrs.foreground);

  Attribute<Color> get primary => get(Attrs.primary);
}
