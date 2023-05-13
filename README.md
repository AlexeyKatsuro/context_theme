# attr_theme

## Specification

Theme declaration:

```dart
abstract class $ColorThemeData with ThemesContext {
  // Required attribute must be not null, and returned value will used as default
  Color get primary => Color(0xFF6200EE);
  
  Color get onPrimary => Color(0xFFFFFFFF);

  Color get secondary => Color(0xFF03DAC6);

  Color get onSecondary => Color(0xFF000000);
  
  Color get background => Color(0xFFFAFAFA);

  Color get onBackground => Colors.black;

  Color get error => Color(0xFFB00020);

  Color get onError => Color(0xFFFFFFFF);

  // Theme attribute could be assigned as link to another attribute
  Color get iconColor => primary;

  // Optional attribute
  Color? get textColor => null;
}
```

Constructor interface output:

```dart
class ColorThemeData extends _$ColorThemeData {
  // All params are optional and if some of them are omitted at installations the defaults ones are used.
  ColorThemeData({
    super.primary,
    super.secondary,
    super.onSecondary,
    super.onPrimary,
    super.iconColor,
    super.textColor,
  });
}
```

Color theme instantiations:

```dart
ColorThemeData light(BuildContext context) {
  // Using default
  return ColorThemeData();
}

ColorThemeData dark(BuildContext context) {
  return ColorThemeData(
      primary: Color(0xFFBB86FC),
      onPrimary: Color(0xFFFFFFFF),
      background: Color(0xFF121212),
      onBackground: Color(0xFFFFFFFF),
      error: Color(0xFFCF6679),
      onError: Color(0xFFFFFFFF),
  );
}

// Dynamic
ColorThemeData build(BuildContext context) {
  return MediaQuery.platformBrightnessOf(context).isLight ? light(context) : dark(context);
}
```

SubTheme declaration:

```dart
abstract class $BorderThemeData with ThemesContext {
  // By default uses primary
  Color get color => context.colorTheme.primary;

  Color get width => 1;
}
```


```dart
abstract class $SimpleButtonThemeData with ThemesContext {
  // By default uses primary
  Color get backgroundColor => context.colorTheme.primary;

  Color get foregroundColor => context.colorTheme.onPrimary;

  BorderThemeData? get borderSize;
}
```

SubTheme instantiation:

```dart
SimpleButtonThemeData build(BuildContext context) {

}
```

Simple usage:

```dart

class SimpleButton extends StatelessWidget {
  const SimpleButton({super.key, this.child});

  final Widge child;

  @override
  Widget build(BuildContext context) {
    final theme = context.simpleButtonTheme;
    return Container(
      color: theme.backgroundColor,
      child: DefaultTextStyle.merge(
        style: TextStyle(color: theme.foregroundColor),
        child: child,
      ),
    );
  }
}
```
