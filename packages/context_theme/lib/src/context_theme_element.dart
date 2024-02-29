part of 'context_theme.dart';

/// An [Element] that uses a [ContextTheme] as its configuration.
class ContextThemeElement extends SingleChildInheritedElement with StyleOwnerContext {
  ContextThemeElement(ContextTheme super.widget);

  @override
  ContextTheme get widget => super.widget as ContextTheme;

  @override
  bool doesHasDepended<S extends Style, T extends ContextTheme<S, T>>(BuildContext dependent) {
    final style = getDependencies(dependent as Element);
    assert(style is S?);
    return style != null;
  }

  @override
  void updateDependencies(Element dependent, Object? aspect) {
    final style = getDependencies(dependent) as Style?;

    if (style == null) {
      final newStyle = _initStyle(dependent, widget._createStyle);
      newStyle._widget = widget;
      if (aspect is _DefaultThemeAspect) {
        newStyle._styleOf = aspect.styleOf;
      }
      setDependencies(dependent, newStyle);
    }
  }

  @override
  S _getStyle<S extends Style, T extends ContextTheme<S, T>>(BuildContext context) {
    final style = getDependencies(context as Element);
    if (style == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('_getStyle was called before dependOnInheritedElement.'),
      ]);
    }
    if (style is! S) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
          'StyleElement with ${widget.runtimeType} widget must have $S type as dependency',
        ),
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
    newStyle._widget = widget;
    newStyle._styleOf = oldStyle?._styleOf;
    setDependencies(dependent, newStyle);
    super.notifyDependent(oldWidget, dependent);
  }

  @override
  StyleOwnerContext? getParentStyleOwner<S extends Style, T extends ContextTheme<S, T>>() {
    {
      StyleOwnerContext? ownerContext;
      visitAncestorElements((parent) {
        ownerContext = parent.getElementForInheritedWidgetOfExactType<T>() as StyleOwnerContext?;
        return false;
      });
      return ownerContext;
    }
  }
}

mixin StyleOwnerContext on InheritedElement {
  StyleOwnerContext? get hostElement;

  StyleOwnerContext? getParentStyleOwner<S extends Style, T extends ContextTheme<S, T>>();

  bool doesHasDepended<S extends Style, T extends ContextTheme<S, T>>(BuildContext dependent);

  S _getStyle<S extends Style, T extends ContextTheme<S, T>>(BuildContext context);

  Style _initStyle(Element dependent, Style Function() createStyle) {
    return createStyle().._mound(dependent, this);
  }
}
