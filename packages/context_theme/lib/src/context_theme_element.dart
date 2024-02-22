part of 'context_theme.dart';

/// An [Element] that uses a [ContextTheme] as its configuration.
class ContextThemeElement extends SingleChildInheritedElement with StyleOwnerContext {
  ContextThemeElement(ContextTheme super.widget);

  @override
  ContextTheme get widget => super.widget as ContextTheme;

  @override
  bool doesHasDepended<StyleType extends Style>(BuildContext dependent) {
    final style = getDependencies(dependent as Element);
    assert(style is StyleType?);
    return style != null;
  }

  @override
  void updateDependencies(Element dependent, Object? aspect) {
    final style = getDependencies(dependent) as Style?;

    if (style == null) {
      final newStyle = _initStyle(dependent, widget._createStyle);

      setDependencies(dependent, newStyle);
    }
  }

  @override
  StyleType _getStyle<StyleType extends Style>(BuildContext context) {
    final style = getDependencies(context as Element);
    if (style == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('_getStyle was called before dependOnInheritedElement.'),
      ]);
    }
    if (style is! StyleType) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
            'StyleElement with ${widget.runtimeType} widget must have $StyleType type as dependency'),
      ]);
    }
    return style;
  }

  @override
  StyleOwnerContext? get hostElement => this;

  @override
  void notifyDependent(InheritedWidget oldWidget, Element dependent) {
    final oldStyle = getDependencies(dependent) as Style?;
    oldStyle?._dispose();
    final newStyle = _initStyle(dependent, widget._createStyle);
    setDependencies(dependent, newStyle);
    super.notifyDependent(oldWidget, dependent);
  }

  @override
  StyleOwnerContext? getParentStyleOwner<I extends ContextTheme<Style>>() {
    {
      StyleOwnerContext? ownerContext;
      visitAncestorElements((parent) {
        ownerContext = parent.getElementForInheritedWidgetOfExactType<I>() as StyleOwnerContext?;
        return false;
      });
      return ownerContext;
    }
  }
}

mixin StyleOwnerContext on InheritedElement {
  StyleOwnerContext? get hostElement;

  StyleOwnerContext? getParentStyleOwner<I extends ContextTheme>();

  bool doesHasDepended<StyleType extends Style>(BuildContext dependent);

  StyleType _getStyle<StyleType extends Style>(BuildContext context);

  Style _initStyle(Element dependent, Style Function() createStyle) {
    return createStyle().._mound(dependent, this);
  }
}
