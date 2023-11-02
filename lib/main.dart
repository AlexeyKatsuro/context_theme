// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:attr_theme/widgets/buttons/app_button.dart';
import 'package:attr_theme/widgets/buttons/outlined_styles.dart';
import 'package:attr_theme/widgets/styles/button.dart';
import 'package:attr_theme/widgets/styles/colors/colors_theme.dart';
import 'package:attr_theme/widgets/styles/style.dart';
import 'package:flutter/material.dart' hide ButtonTheme;

import 'widgets/buttons/filled_styles.dart';
import 'widgets/buttons/icon_styles.dart';
import 'widgets/styles/buttons/theme.dart';

void emptyCallback() {}
const ColorScheme _colorSchemeLightM2 = ColorScheme.light();
const ColorScheme _colorSchemeDarkM2 = ColorScheme.dark();

const ColorScheme _colorSchemeLightM3 = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF6750A4),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFEADDFF),
  onPrimaryContainer: Color(0xFF21005D),
  secondary: Color(0xFF625B71),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE8DEF8),
  onSecondaryContainer: Color(0xFF1D192B),
  tertiary: Color(0xFF7D5260),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD8E4),
  onTertiaryContainer: Color(0xFF31111D),
  error: Color(0xFFB3261E),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFF9DEDC),
  onErrorContainer: Color(0xFF410E0B),
  background: Color(0xFFFFFBFE),
  onBackground: Color(0xFF1C1B1F),
  surface: Color(0xFFFFFBFE),
  onSurface: Color(0xFF1C1B1F),
  surfaceVariant: Color(0xFFE7E0EC),
  onSurfaceVariant: Color(0xFF49454F),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFF313033),
  onInverseSurface: Color(0xFFF4EFF4),
  inversePrimary: Color(0xFFD0BCFF),
  // The surfaceTint color is set to the same color as the primary.
  surfaceTint: Color(0xFF6750A4),
);

const ColorScheme _colorSchemeDarkM3 = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFD0BCFF),
  onPrimary: Color(0xFF381E72),
  primaryContainer: Color(0xFF4F378B),
  onPrimaryContainer: Color(0xFFEADDFF),
  secondary: Color(0xFFCCC2DC),
  onSecondary: Color(0xFF332D41),
  secondaryContainer: Color(0xFF4A4458),
  onSecondaryContainer: Color(0xFFE8DEF8),
  tertiary: Color(0xFFEFB8C8),
  onTertiary: Color(0xFF492532),
  tertiaryContainer: Color(0xFF633B48),
  onTertiaryContainer: Color(0xFFFFD8E4),
  error: Color(0xFFF2B8B5),
  onError: Color(0xFF601410),
  errorContainer: Color(0xFF8C1D18),
  onErrorContainer: Color(0xFFF9DEDC),
  background: Color(0xFF1C1B1F),
  onBackground: Color(0xFFE6E1E5),
  surface: Color(0xFF1C1B1F),
  onSurface: Color(0xFFE6E1E5),
  surfaceVariant: Color(0xFF49454F),
  onSurfaceVariant: Color(0xFFCAC4D0),
  inverseSurface: Color(0xFFE6E1E5),
  onInverseSurface: Color(0xFF313033),
  inversePrimary: Color(0xFF6750A4),
  // The surfaceTint color is set to the same color as the primary.
  surfaceTint: Color(0xFFD0BCFF),
);

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: themeMode,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(
        title: 'Theme',
        onThemeChanged: (value) {
          setState(() {
            themeMode = value;
          });
        },
      ),
      builder: (context, child) {
        final theme = Theme.of(context);
        return MultiTheme(
          themes: [
            ColorsTheme(
                style: theme.brightness.isDark ? LightColorsStyle.new : DarkColorsStyle.new),
            ButtonTheme(style: DefaultButtonStyle.new),
            ButtonTheme(style: RoundedButtonStyle.new),
          ],
          child: Center(
            child: child!,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.onThemeChanged});

  final String title;

  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorStyle = context.colorsStyle;
    return Scaffold(
      backgroundColor: colorStyle.background,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: colorStyle.primary,
        foregroundColor: colorStyle.onPrimary,
        actions: [
          IconButton(
            icon: theme.brightness.isDark
                ? const Icon(Icons.light_mode_outlined)
                : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              widget.onThemeChanged(theme.brightness.isDark ? ThemeMode.light : ThemeMode.dark);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: MultiTheme(
                themes: [
                  ButtonTheme(style: RoundedButtonStyle.new),
                  ButtonTheme(style: AccentButtonStyle.new),
                ],
                child: Column(
                  children: [
                    Button(
                      child: Text('Button'),
                    ),
                    ColorsTheme(
                      style: BlackColorsStyle.new,
                      child: Button(
                        child: Text('Button'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardsList extends StatelessWidget {
  const CardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        Text('Weekly stats'),
        SizedBox(height: 12),
        InfoCard(
          overline: Text('Marketing'),
          title: Text('123.4 M'),
          caption: Text('+12.3% of target'),
          secondaryAction: AppButton(
            child: Text('Cancel'),
            onPressed: emptyCallback,
          ),
          primaryAction: AppButton(
            child: Text('Apply'),
            onPressed: emptyCallback,
          ),
          cornerAction: AppButton(
            child: Icon(Icons.info_outline_rounded),
            onPressed: emptyCallback,
          ),
        ),
        const SizedBox(height: 6),
        PrimaryContainerTheme(
          child: InfoCard(
            overline: Text('Sells'),
            title: Text('423.4 M'),
            caption: Text('+4.01% of target'),
            secondaryAction: AppButton(
              child: Text('Cancel'),
              onPressed: emptyCallback,
            ),
            primaryAction: AppButton(
              child: Text('Review'),
              onPressed: emptyCallback,
            ),
            cornerAction: AppButton(
              child: Icon(Icons.share_outlined),
              onPressed: emptyCallback,
            ),
          ),
        ),
        const SizedBox(height: 6),
        ErrorContainerTheme(
          child: InfoCard(
            overline: Text('Losses'),
            title: Text('50.4 M'),
            caption: Text('-1.01% of target'),
            secondaryAction: AppButton(
              child: Text('Cancel'),
              onPressed: emptyCallback,
            ),
            primaryAction: AppButton(
              child: Text('Review'),
              onPressed: emptyCallback,
            ),
            cornerAction: AppButton(
              child: Icon(Icons.help_outline_outlined),
              onPressed: emptyCallback,
            ),
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.cornerAction,
    required this.overline,
    required this.title,
    required this.caption,
    required this.secondaryAction,
    required this.primaryAction,
  });

  final Widget cornerAction;
  final Widget overline;
  final Widget title;
  final Widget caption;
  final Widget secondaryAction;
  final Widget primaryAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                      child: DefaultTextStyle.merge(
                    child: overline,
                    style: theme.textTheme.labelSmall,
                  )),
                  AppButtonTheme.merge(
                    data: IconButtonStyle(context),
                    child: cornerAction,
                  ),
                ],
              ),
              DefaultTextStyle.merge(child: title, style: theme.textTheme.headlineSmall),
              DefaultTextStyle.merge(
                child: caption,
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: AppButtonTheme.merge(
                      data: OutlinedButtonStyle(context),
                      child: secondaryAction,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButtonTheme.merge(
                      data: FilledButtonStyle(context),
                      child: primaryAction,
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

extension BrightnessExt on Brightness {
  bool get isDark => this == Brightness.dark;

  bool get isLight => this == Brightness.light;
}

class PrimaryContainerTheme extends StatelessWidget {
  const PrimaryContainerTheme({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Theme(
        data: ThemeData(
            brightness: theme.brightness,
            useMaterial3: theme.useMaterial3,
            colorScheme: theme.colorScheme.copyWith(
              primary: colorScheme.onPrimaryContainer,
              surface: colorScheme.primaryContainer,
              onPrimary: colorScheme.primaryContainer,
              onBackground: colorScheme.onPrimaryContainer,
              onSurface: colorScheme.onPrimaryContainer,
              background: colorScheme.primaryContainer,
              outline: colorScheme.onPrimaryContainer,
            )),
        child: child);
  }
}

class ErrorContainerTheme extends StatelessWidget {
  const ErrorContainerTheme({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Theme(
        data: ThemeData(
            brightness: theme.brightness,
            useMaterial3: theme.useMaterial3,
            colorScheme: theme.colorScheme.copyWith(
              primary: colorScheme.onErrorContainer,
              surface: colorScheme.errorContainer,
              onPrimary: colorScheme.errorContainer,
              onBackground: colorScheme.onErrorContainer,
              onSurface: colorScheme.onErrorContainer,
              background: colorScheme.errorContainer,
              outline: colorScheme.onErrorContainer,
            )),
        child: child);
  }
}
