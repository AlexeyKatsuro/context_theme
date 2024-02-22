import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' hide CardTheme;
import 'package:flutter_test/flutter_test.dart';

import 'themes/card_theme.dart';
import 'themes/text_theme.dart';

void main() {
  testWidgets('should merge styles with MultiTheme', (tester) async {
    Color? background;
    Color? foreground;
    await tester.pumpWidget(
      MultiTheme(
        themes: const [
          CardTheme(style: RedBackgroundCardStyle.new),
          CardTheme(style: RedForegroundCardStyle.new),
        ],
        child: Builder(
          builder: (context) {
            background = context.cardTheme.background;
            foreground = context.cardTheme.foreground;
            return const SizedBox();
          },
        ),
      ),
    );

    expect(background, Colors.red);
    expect(foreground, Colors.red);
  });

  testWidgets('should merge styles with nested themes', (tester) async {
    Color? background;
    Color? foreground;
    await tester.pumpWidget(
      CardTheme(
        style: RedForegroundCardStyle.new,
        child: CardTheme(
          style: RedBackgroundCardStyle.new,
          child: Builder(
            builder: (context) {
              background = context.cardTheme.background;
              foreground = context.cardTheme.foreground;
              return const SizedBox();
            },
          ),
        ),
      ),
    );

    expect(background, Colors.red);
    expect(foreground, Colors.red);
  });

  testWidgets('should merge styles with not directly nested themes', (tester) async {
    Color? background;
    Color? foreground;
    Color? middleBackground;
    Color? middleForeground;
    await tester.pumpWidget(
      DefaultThemeScope(
        child: CardTheme(
          style: RedForegroundCardStyle.new,
          child: Builder(
            builder: (context) {
              middleBackground = context.cardTheme.background;
              middleForeground = context.cardTheme.foreground;
              return CardTheme(
                style: RedBackgroundCardStyle.new,
                child: Builder(
                  builder: (context) {
                    background = context.cardTheme.background;
                    foreground = context.cardTheme.foreground;
                    return const SizedBox();
                  },
                ),
              );
            },
          ),
        ),
      ),
    );

    expect(middleBackground, Colors.white); // from DefaultCardStyle

    expect(middleForeground, Colors.red);

    expect(background, Colors.red);
    expect(foreground, Colors.red);
  });

  testWidgets(
    "shouldn't trigger rebuild for widgets that don't depend on changed styles",
        (tester) async {
      var buildCount = 0;
      final child = Builder(
        builder: (context) {
          context.cardTheme;
          buildCount++;
          return const SizedBox();
        },
      );

      await tester.pumpWidget(
        MultiTheme(
          themes: const [
            CardTheme(style: RedBackgroundCardStyle.new),
            FontTheme(style: SmallFontStyle.new),
          ],
          child: child,
        ),
      );

      expect(buildCount, equals(1));

      await tester.pumpWidget(
        MultiTheme(
          themes: const [
            CardTheme(style: RedBackgroundCardStyle.new),
            FontTheme(style: BigFontStyle.new),
          ],
          child: child,
        ),
      );
      expect(buildCount, equals(1));
    },
  );
}
