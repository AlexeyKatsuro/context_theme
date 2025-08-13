// ignore_for_file: avoid_implementing_value_types

import 'package:flutter/widgets.dart';

import 'single_inherited_widget.dart';

abstract class SingleChildInheritedTheme extends SingleChildInheritedWidget
    implements InheritedTheme {
  const SingleChildInheritedTheme({super.key, super.child});
}
