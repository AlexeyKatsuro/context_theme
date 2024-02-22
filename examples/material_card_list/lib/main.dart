import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' hide MaterialButton, ButtonTheme, CardTheme;
import 'package:material_context_theme/material_context_theme.dart';

void emptyCallback() {}

void main() {
  runApp(const App());
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
      theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: MyHomePage(
        title: 'Theme',
        onThemeChanged: (value) {
          setState(() {
            themeMode = value;
          });
        },
      ),
      builder: (context, child) {
        return DefaultThemeScope(child: child!);
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
  bool isLocked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: isLocked
                ? const Icon(Icons.lock_outline_rounded)
                : const Icon(Icons.lock_open_rounded),
            onPressed: () {
              setState(() {
                isLocked;
              });
            },
          ),
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
      body: MaterialStateScope.merge(
        states: {},
        child: const CardsList(),
      ),
    );
  }
}

extension BrightnessExt on Brightness {
  bool get isDark => this == Brightness.dark;

  bool get isLight => this == Brightness.light;
}

class CardsList extends StatelessWidget {
  const CardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        const Text('Weekly stats'),
        const SizedBox(height: 12),
        const InfoCard(
          overline: Text('Marketing'),
          title: Text('123.4 M'),
          caption: Text('+12.3% of target'),
          secondaryAction: MaterialButton(
            onPressed: emptyCallback,
            child: Text('Cancel'),
          ),
          primaryAction: MaterialButton(
            onPressed: emptyCallback,
            child: Text('Apply'),
          ),
          cornerAction: MaterialButton(
            onPressed: emptyCallback,
            child: Icon(Icons.info_outline_rounded),
          ),
        ),
        const SizedBox(height: 6),
        const ColorsTheme(
          style: PrimaryContainerColorsStyle.new,
          child: InfoCard(
            overline: Text('Sells'),
            title: Text('423.4 M'),
            caption: Text('+4.01% of target'),
            secondaryAction: MaterialButton(
              onPressed: emptyCallback,
              child: Text('Cancel'),
            ),
            primaryAction: MaterialButton(
              onPressed: emptyCallback,
              child: Text('Review'),
            ),
            cornerAction: MaterialButton(
              onPressed: emptyCallback,
              child: Icon(Icons.share_outlined),
            ),
          ),
        ),
        const SizedBox(height: 6),
        const ColorsTheme(
          style: ErrorContainerColorsStyle.new,
          child: InfoCard(
            overline: Text('Losses'),
            title: Text('50.4 M'),
            caption: Text('-1.01% of target'),
            secondaryAction: MaterialButton(
              onPressed: emptyCallback,
              child: Text('Cancel'),
            ),
            primaryAction: MaterialButton(
              onPressed: emptyCallback,
              child: Text('Review'),
            ),
            cornerAction: MaterialButton(
              onPressed: emptyCallback,
              child: Icon(Icons.help_outline_outlined),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Builder(builder: (context) {
          var selected = false;
          return StatefulBuilder(builder: (context, setState) {
            return MaterialStateScope(
              states: {if (selected) MaterialState.selected},
              child: ColorsTheme(
                style: PrimaryContainerColorsStyle.new,
                child: InfoCard(
                  overline: const Text('Losses'),
                  title: const Text('50.4 M'),
                  caption: const Text('-1.01% of target'),
                  secondaryAction: const MaterialButton(
                    onPressed: emptyCallback,
                    child: Text('Cancel'),
                  ),
                  primaryAction: const MaterialButton(
                    onPressed: emptyCallback,
                    child: Text('Review'),
                  ),
                  cornerAction: Builder(builder: (context) {
                    return Switch(
                      value: selected,
                      activeTrackColor: context.colorScheme.primary,
                      activeColor: context.colorScheme.onPrimary,
                      onChanged: (value) {
                        setState(() {
                          selected = value;
                        });
                      },
                    );
                  }),
                ),
              ),
            );
          });
        }),
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
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return MaterialCard(
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
                style: textTheme.labelSmall,
              )),
              ButtonTheme(
                style: IconButtonStyle.new,
                child: cornerAction,
              ),
            ],
          ),
          DefaultTextStyle.merge(child: title, style: textTheme.headlineSmall),
          DefaultTextStyle.merge(
            child: caption,
            style: textTheme.bodySmall.copyWith(color: colorScheme.primary),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ButtonTheme(
                  style: OutlinedButtonStyle.new,
                  child: secondaryAction,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ButtonTheme(
                  style: FilledButtonStyle.new,
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

class PrimaryContainerColorsStyle extends InheritColorsStyle {
  @override
  Color get primary => link.onPrimaryContainer;

  @override
  Color get onPrimary => link.primaryContainer;

  @override
  Color get surface => link.primaryContainer;

  @override
  Color get onSurface => link.onPrimaryContainer;

  @override
  Color get background => link.primaryContainer;

  @override
  Color get onBackground => link.onPrimaryContainer;
}

class ErrorContainerColorsStyle extends InheritColorsStyle {
  @override
  Color get primary => link.onErrorContainer;

  @override
  Color get onPrimary => link.errorContainer;

  @override
  Color get surface => link.errorContainer;

  @override
  Color get onSurface => link.onErrorContainer;

  @override
  Color get background => link.errorContainer;

  @override
  Color get onBackground => link.onErrorContainer;
}
