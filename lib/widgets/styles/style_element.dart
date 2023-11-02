part of 'style.dart';

/// An [Element] that uses a [WidgetTheme] as its configuration.
class StyleElement extends InheritedElement implements StyleOwnerContext {
  StyleElement(WidgetTheme widget) : super(widget);

  @override
  WidgetTheme get widget => super.widget as WidgetTheme;

  @override
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

  @override
  StyleOwnerContext? getParentStyleOwner<I extends WidgetTheme<Style>>() {
    {
      StyleOwnerContext? inheritedElement;
      visitAncestorElements((parent) {
        inheritedElement = parent.getElementForInheritedWidgetOfExactType<I>() as StyleOwnerContext;
        return false;
      });
      return inheritedElement;
    }
  }
}

abstract interface class StyleOwnerContext implements InheritedElement {
  StyleOwnerContext? getParentStyleOwner<I extends WidgetTheme>();

  bool doesHasDepended(BuildContext dependent);

  Style getStyle(BuildContext context);

}
