part of 'style.dart';

/// An [Element] that uses a [WidgetTheme] as its configuration.
class StyleElement extends InheritedElement {
  StyleElement(WidgetTheme widget) : super(widget);

  @override
  WidgetTheme get widget => super.widget as WidgetTheme;

  @override
  InheritedElement? getElementForInheritedWidgetOfExactType<I extends InheritedWidget>() {
    InheritedElement? inheritedElement;

    // An InheritedProvider<T>'s update tries to obtain a parent provider of
    // the same type.
    visitAncestorElements((parent) {
      inheritedElement = parent.getElementForInheritedWidgetOfExactType<I>();
      return false;
    });
    return inheritedElement;
  }

  bool doesHasDepended(BuildContext dependent) {
    return getDependencies(dependent as Element) != null;
  }

  Style getStyle(BuildContext context) {
    final style = getDependencies(context as Element) as Style?;
    assert(style != null);
    return style!;
  }

  @override
  void updateDependencies(Element dependent, Object? aspect) {
    final style = getDependencies(dependent) as Style?;

    if (style == null) {
      final newStyle = initStyle(dependent);

      setDependencies(dependent, newStyle);
    }
  }

  Style initStyle(Element dependent) {
    return widget.createStyle()
      .._element = dependent
      .._hostElement = this;
  }

  @override
  void notifyDependent(InheritedWidget oldWidget, Element dependent) {
    final oldStyle = getDependencies(dependent) as Style?;
    oldStyle?._dispose();
    final newStyle = initStyle(dependent);
    setDependencies(dependent, newStyle);
    super.notifyDependent(oldWidget, dependent);
  }
}
