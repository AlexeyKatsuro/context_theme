import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

abstract class SingleChildInheritedWidget extends InheritedWidget implements SingleChildWidget {
  const SingleChildInheritedWidget({super.key, Widget? child})
      : _child = child,
        super(child: child ?? const SizedBox());

  final Widget? _child;

  @override
  @protected
  Widget get child => _child!;

  @override
  SingleChildInheritedElementMixin createElement();
}

class SingleChildInheritedElement extends InheritedElement
    with SingleChildWidgetElementMixin, SingleChildInheritedElementMixin {
  SingleChildInheritedElement(SingleChildInheritedWidget super.widget);

  @override
  SingleChildInheritedWidget get widget => super.widget as SingleChildInheritedWidget;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    visitChildren((e) => e.debugFillProperties(properties));
  }
}
