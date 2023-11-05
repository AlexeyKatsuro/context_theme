// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:attr_theme/utils/material_states/material_state_scope.dart';
import 'package:attr_theme/utils/material_states/material_states_extension.dart';
import 'package:attr_theme/widgets/buttons/app_button.dart';
import 'package:attr_theme/widgets/buttons/outlined_button_styles.dart';
import 'package:attr_theme/widgets/cards/app_card_theme.dart';
import 'package:attr_theme/widgets/styles/colors/colors_theme.dart';
import 'package:attr_theme/widgets/styles/style.dart';
import 'package:attr_theme/widgets/styles/typography_styles.dart';
import 'package:flutter/material.dart' hide ButtonTheme, CardTheme;

import 'widgets/buttons/base_styles.dart';
import 'widgets/buttons/filled_button_styles.dart';
import 'widgets/buttons/icon_button_style.dart';
import 'widgets/buttons/text_button_styles.dart';
import 'widgets/cards/app_card.dart';

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
      theme: ThemeData.from(useMaterial3: true, colorScheme: _colorSchemeLightM2),
      darkTheme: ThemeData.from(useMaterial3: true, colorScheme: _colorSchemeDarkM2),
      home: MyHomePage(
        title: 'Theme',
        onThemeChanged: (value) {
          setState(() {
            themeMode = value;
          });
        },
      ),
      builder: (context, child) {
        return MultiTheme(
          themes: [
            ColorsTheme(style: MaterialColorsStyle.new),
            TypographyTheme(style: MaterialTypographyStyle.new),
            CardTheme(style: BaseCardStyle.new),
            ButtonTheme(style: BaseButtonStyle.new),
          ],
          child: child!,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      body: CardsList(),
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
        ColorsTheme(
          style: PrimaryContainerColorsStyle.new,
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
        ColorsTheme(
          style: ErrorContainerColorsStyle.new,
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
        const SizedBox(height: 6),
        SelectableInfoCard(),
      ],
    );
  }
}

class SelectableInfoCard extends StatefulWidget {
  const SelectableInfoCard({super.key});

  @override
  State<SelectableInfoCard> createState() => _SelectableInfoCardState();
}

class _SelectableInfoCardState extends State<SelectableInfoCard> {
  final MaterialStatesController _statesController = MaterialStatesController({
    MaterialState.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _statesController,
      builder: (context, child) {
        return ColorsTheme(
          style: !_statesController.value.isSelected
              ? PrimaryContainerColorsStyle.new
              : ColorsStyle.new,
          child: child,
        );
      },
      child: MaterialStateScope(
        states: _statesController,
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
          cornerAction: Builder(builder: (context) {
            return Switch(
              value: context.isSelected,
                activeTrackColor: context.colorScheme.primary,
              activeColor: context.colorScheme.onPrimary,
              onChanged: (value) {
                _statesController.update(MaterialState.selected, value);
              },
            );
          }),
        ),
      ),
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
    return AppCard(
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

class PrimaryContainerColorsStyle extends ColorsStyle {
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

class ErrorContainerColorsStyle extends ColorsStyle {
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
