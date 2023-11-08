import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class MultiTheme extends Nested {
  MultiTheme({
    Key? key,
    required List<SingleChildWidget> themes,
    Widget? child,
  }) : super(
    key: key,
    children: themes,
    child: child,
  );
}

class ThemeAdapter extends SingleChildBuilder {
  const ThemeAdapter({super.key, required super.builder, super.child});
}
