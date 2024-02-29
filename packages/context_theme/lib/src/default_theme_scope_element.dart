part of 'context_theme.dart';

class _DefaultThemeDependencies {
  _DefaultThemeDependencies() : styles = {};
  final Map<Type, Style> styles;
}

class _DefaultThemeAspect<S extends Style, T extends ContextTheme<S, T>> {
  _DefaultThemeAspect(this.createStyle, { required this.styleOf});

  Type get themeType => T;
  final CreateStyle<S> createStyle;
  final StyleOf<S> styleOf;
}

class DefaultThemeScopeElement extends SingleChildInheritedElement with StyleOwnerContext {
  DefaultThemeScopeElement(super.widget);

  @override
  void updateDependencies(Element dependent, Object? aspect) {
    if (aspect is! _DefaultThemeAspect) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('Aspect of DefaultThemeScope must be not null and DefaultThemeAspect type'),
      ]);
    }
    final dependencies =
        getDependencies(dependent) as _DefaultThemeDependencies? ?? _DefaultThemeDependencies();
    if (!dependencies.styles.containsKey(aspect.themeType)) {
      final newStyle = _initStyle(dependent, aspect.createStyle);
      newStyle._styleOf = aspect.styleOf;
      dependencies.styles[aspect.themeType] = newStyle;
      setDependencies(dependent, dependencies);
    }
  }

  @override
  StyleOwnerContext? get hostElement => null;

  @override
  StyleOwnerContext? getParentStyleOwner<S extends Style, T extends ContextTheme<S, T>>() {
    return null;
  }

  @override
  bool doesHasDepended<S extends Style, T extends ContextTheme<S, T>>(BuildContext dependent) {
    final dependencies = getDependencies(dependent as Element) as _DefaultThemeDependencies?;
    final style = dependencies?.styles[T];
    assert(style is S?);
    return style != null;
  }

  @override
  S _getStyle<S extends Style, T extends ContextTheme<S, T>>(BuildContext context) {
    final dependencies = getDependencies(context as Element);
    if (dependencies == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('_getStyle was called before dependOnInheritedElement.'),
      ]);
    }
    if (dependencies is! _DefaultThemeDependencies) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
          'DefaultThemeScope must have only _DefaultThemeDependencies type as Dependencies',
        ),
      ]);
    }
    final style = dependencies.styles[T];
    if (style == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary("StyleType wasn't registered as dependency"),
      ]);
    }
    return style as S;
  }
}
