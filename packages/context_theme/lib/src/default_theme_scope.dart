part of 'style.dart';

class DefaultThemeScope extends SingleChildInheritedWidget {
  const DefaultThemeScope({
    super.key,
    super.child,
  }) : super();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  @override
  DefaultThemeScopeElement createElement() => DefaultThemeScopeElement(this);
}
