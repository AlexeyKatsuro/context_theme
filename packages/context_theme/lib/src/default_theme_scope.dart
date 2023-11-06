part of 'style.dart';

class DefaultThemeScope extends SingleChildInheritedWidget {
  const DefaultThemeScope({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  @override
  DefaultThemeScopeElement createElement() => DefaultThemeScopeElement(this);
}
