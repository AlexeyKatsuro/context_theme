part of 'context_theme.dart';

class _ThemeDependencies {
  _ThemeDependencies() : styles = {};
  final Map<_ThemeAspect, Style> styles;
}

@immutable
class _ThemeAspect<S extends Style, T extends ContextTheme<S, T>> {
  const _ThemeAspect({required this.styleOf, required this.linkTo});

  final StyleOf<S, T> styleOf;
  final StyleOf<S, ContextTheme<S, dynamic>>? linkTo;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ThemeAspect &&
          runtimeType == other.runtimeType &&
          styleOf == other.styleOf &&
          linkTo == other.linkTo;

  @override
  int get hashCode => styleOf.hashCode ^ linkTo.hashCode;

  @override
  String toString() {
    return '_DefaultThemeAspect{styleOf: $styleOf, linkTo: $linkTo}';
  }
}

class DefaultThemeScopeElement extends SingleChildInheritedElement with StyleOwnerContext {
  DefaultThemeScopeElement(super.widget);

  Style _initStyle(Element dependent, _ThemeAspect aspect) {
    final style = aspect.styleOf.defaultStyle();
    style._dependentElement = dependent;
    style._hostElement = this;
    style._styleOf = aspect.styleOf;
    style._linkTo = aspect.linkTo;
    return style;
  }

  @override
  StyleOwnerContext? getParentStyleOwner<S extends Style, T extends ContextTheme<S, T>>() {
    return null;
  }
}
