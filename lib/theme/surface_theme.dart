import 'package:flutter/material.dart';
import 'attr_theme.dart';
import 'attribute.dart';
import '../attributes/core/attrs.dart';

class SurfaceTheme extends AttrTheme {
  const SurfaceTheme({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static SurfaceThemeGetter of(BuildContext context) {
    return throw '';
  }

  @override
  Iterable<Attribute> buildAttributes(BuildContext context) {
    return [
      const AttributeValueColor(name: Attrs.background, value: Colors.white),
      const AttributeValueColor(name: Attrs.foreground, value: Colors.blue),
    ];
  }
}

mixin SurfaceThemeGetter on AttrThemeGetter {
  Attribute<Color> get background => get(Attrs.background);

  Attribute<Color> get foreground => get(Attrs.foreground);
}
