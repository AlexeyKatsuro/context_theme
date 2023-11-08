part of 'context_theme.dart';

class _DefaultThemeDependencies {

  _DefaultThemeDependencies() : styles = {};
  final Map<Type, Style> styles;
}

class _DefaultThemeAspect<StyleType extends Style> {
  _DefaultThemeAspect(this.createStyle);

  Type get type => StyleType;
  final CreateStyle<StyleType> createStyle;
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
    if (!dependencies.styles.containsKey(aspect.type)) {
      final newStyle = _initStyle(dependent, aspect.createStyle);
      dependencies.styles[aspect.type] = newStyle;
      setDependencies(dependent, dependencies);
    }
  }

  @override
  StyleOwnerContext? get hostElement => null;

  @override
  StyleOwnerContext? getParentStyleOwner<I extends ContextTheme<Style>>() {
    return null;
  }

  @override
  bool doesHasDepended<StyleType extends Style>(BuildContext dependent) {
    final dependencies = getDependencies(dependent as Element) as _DefaultThemeDependencies?;
    final style = dependencies?.styles[StyleType];
    return style != null;
  }

  @override
  StyleType _getStyle<StyleType extends Style>(BuildContext context) {
    final dependencies = getDependencies(context as Element);
    if (dependencies == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('_getStyle was called before dependOnInheritedElement.'),
      ]);
    }
    if (dependencies is! _DefaultThemeDependencies) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
            'DefaultThemeScope must have only _DefaultThemeDependencies type as Dependencies'),
      ]);
    }
    final style = dependencies.styles[StyleType];
    if (style == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary("StyleType wasn't registered as dependency"),
      ]);
    }
    return style as StyleType;
  }
}
