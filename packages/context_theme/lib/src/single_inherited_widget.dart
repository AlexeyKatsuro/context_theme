import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

abstract class SingleChildInheritedWidget extends DiagnosticableTree
    implements SingleChildWidget, InheritedWidget {
  const SingleChildInheritedWidget({this.key, Widget? child}) : _child = child;

  @override
  final Key? key;

  final Widget? _child;

  /// A short, textual description of this widget.
  @override
  String toStringShort() {
    final String type = objectRuntimeType(this, 'Widget');
    return key == null ? type : '$type-$key';
  }

  @override
  @nonVirtual
  bool operator ==(Object other) => super == other;

  @override
  @nonVirtual
  int get hashCode => super.hashCode;

  @override
  @protected
  Widget get child => _child!;

  @override
  SingleChildInheritedElementMixin createElement();
}

class SingleChildInheritedElement extends InheritedElement
    with SingleChildWidgetElementMixin, SingleChildInheritedElementMixin {
  SingleChildInheritedElement(SingleChildInheritedWidget widget) : super(widget);

  @override
  SingleChildInheritedWidget get widget => super.widget as SingleChildInheritedWidget;
}
