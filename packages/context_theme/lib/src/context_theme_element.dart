part of 'context_theme.dart';

/// An [Element] that uses a [ContextTheme] as its configuration.
class ContextThemeElement extends SingleChildInheritedElement with StyleOwnerContext {
  ContextThemeElement(ContextTheme super.widget);

  @override
  ContextTheme get widget => super.widget as ContextTheme;

  Style _initStyle(Element dependent, _ThemeAspect aspect) {
    final style = widget._createStyle();
    style._widget = widget;
    style._dependentElement = dependent;
    style._hostElement = this;
    style._styleOf = aspect.styleOf;
    style._linkTo = aspect.linkTo;
    return style;
  }

  @override
  void notifyDependent(InheritedWidget oldWidget, Element dependent) {
    final oldDependencies = _getDependencies(dependent);
    final dependencies = _ThemeDependencies();
    for (final MapEntry(key: styleOf, value: oldStyle) in oldDependencies.styles.entries) {
      oldStyle._dispose();
      final newStyle = _initStyle(dependent, styleOf);
      dependencies.styles[styleOf] = newStyle;
    }
    setDependencies(dependent, dependencies);
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
  StyleOwnerContext? getParentStyleOwner<S extends Style, T extends ContextTheme<S, T>>();

  _ThemeDependencies _getDependencies(Element dependent) {
    return super.getDependencies(dependent) as _ThemeDependencies? ?? _ThemeDependencies();
  }

  _ThemeDependencies _requireDependencies(Element dependent) {
    final dependencies = getDependencies(dependent);
    if (dependencies == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('_getStyle was called before dependOnInheritedElement.'),
      ]);
    }
    if (dependencies is! _ThemeDependencies) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
          'DefaultThemeScope must have only _DefaultThemeDependencies type as Dependencies',
        ),
      ]);
    }
    return dependencies;
  }

  @override
  void updateDependencies(Element dependent, Object? aspect) {
    if (aspect is! _ThemeAspect) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('Aspect of ContextTheme must be not null and DefaultThemeAspect type'),
      ]);
    }
    final dependencies = _getDependencies(dependent);
    if (!dependencies.styles.containsKey(aspect)) {
      dependencies.styles[aspect] = _initStyle(dependent, aspect);
      setDependencies(dependent, dependencies);
    }
  }

  S _getStyle<S extends Style, T extends ContextTheme<S, T>>(
    BuildContext dependent,
    _ThemeAspect<S, T> aspect,
  ) {
    final dependencies = _requireDependencies(dependent as Element);
    final style = dependencies.styles[aspect];
    if (style == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary("$S with $T wasn't registered as dependency"),
      ]);
    }
    return style as S;
  }

  Style _initStyle(Element dependent, _ThemeAspect aspect);
}
