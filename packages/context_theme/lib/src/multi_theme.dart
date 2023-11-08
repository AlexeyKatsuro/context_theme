import 'package:nested/nested.dart';

class MultiTheme extends Nested {
  MultiTheme({
    super.key,
    required List<SingleChildWidget> themes,
    super.child,
  }) : super(
    children: themes,
  );
}

class ThemeAdapter extends SingleChildBuilder {
  const ThemeAdapter({super.key, required super.builder, super.child});
}
