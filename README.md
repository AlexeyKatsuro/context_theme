# attr_theme

## Specification

### Theme declaration:

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
  return MediaQuery
      .platformBrightnessOf(context)
      .isLight ? light(context) : dark(context);
}
```

### SubTheme declaration:

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

### States(pressed, hovered, focused, selected, disabled, error)

Here should be ability to add new states

States should be provided by Context like

```dart

Set<State> allStates = context.states; 
````

Note: widget can be in several states in the same time. like (hovered & error).

Also here should be possibility to subscribe only for one state:

```dart

bool isPressed = context.isPressed; 
````

Here context should be rebuild only in case if pressed state is added or removed in `states`.
Any updates shouldn't occur if states are changed with another like `disable` or `error`.

State using

Could be used directly in style declaration

```dart
abstract class $SimpleButtonThemeData with ThemesContext {
  Color get backgroundColor =>
      context.isDisabled ?
      context.colorTheme.onSurface.withOpacity(0.12) :
      context.colorTheme.primary;

  Color get foregroundColor =>
      context.isDisabled ?
      context.colorTheme.onSurface.withOpacity(0.38) :
      context.colorTheme.primary;

  // Here we override only border color for error state, the default width is used from context
  // And in not error case whole border style will be took from context
  BorderThemeData? get borderSize {
    if (context.isError) {
      retrun BorderThemeData(color: context.colorTheme.error);
    }
    return null;
  }
}
```

State specific style.

It is much more convenient to create styles for a certain state, and just combine them after into
one:

```dart
SimpleButtonThemeData _disableStyle(BuildContext context) {
  return SimpleButtonThemeData(
    backgroundColor: context.colorTheme.onSurface.withOpacity(0.12),
    foregroundColor: context.colorTheme.onSurface.withOpacity(0.38),
    borderSize: null, // <- remove border
  );
}

// Here we create pressed style based on default or overridden `bg` and `fg` colors by blending them 
// and assign result color as `backgroundColor`
SimpleButtonThemeData _pressedStyle(BuildContext context) {
  // Get default or overridden bg of SimpleButtonThemeData style
  final background = context.simpleButtonTheme.backgroundColor;
  final foreground = context.simpleButtonTheme.foregroundColor.withOpacity(0.10);
  final highlighted = Color.alphaBlend(foreground, background);
  
  // Note we omit foregroundColor and borderSize this way the default values will be used
  return SimpleButtonThemeData(
    backgroundColor: highlighted,
  );
}

SimpleButtonThemeData buttonStyle(BuildContext context) {
    // order according priority
    if(context.isDisabled) return _disableStyle(context);
    if(context.isPressed) return _pressedStyle(context);
    // We can handle mixed scenario
    // if(context.isFocused && context.isHovered) return _focusedHoveredStyle(context);
    // if(context.isFocused) return _focusedStyle(context);
    // if(context.isHovered) return _hoveredStyle(context);
    
    // default
    return const SimpleButtonThemeData();
}
```