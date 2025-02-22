import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' hide CardTheme;
import 'package:flutter_test/flutter_test.dart';

import 'themes/card_theme.dart';
import 'themes/text_theme.dart';

void main() {
  group('ContextTheme with MultiTheme and Nested Themes', () {
    group('Style merging behavior', () {
      testWidgets('merges styles with MultiTheme', (tester) async {
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

        expect(
          background,
          Colors.red,
          reason: 'Background should be merged from RedBackgroundCardStyle.',
        );
        expect(
          foreground,
          Colors.red,
          reason: 'Foreground should be merged from RedForegroundCardStyle.',
        );
      });

      testWidgets('merges styles with nested themes', (tester) async {
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

        expect(
          background,
          Colors.red,
          reason: 'Background should be overridden by RedBackgroundCardStyle.',
        );
        expect(
          foreground,
          Colors.red,
          reason: 'Foreground should be overridden by RedForegroundCardStyle.',
        );
      });

      testWidgets('merges styles with non-directly nested themes', (tester) async {
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

        expect(
          middleBackground,
          Colors.white,
          reason: 'Middle background should come from DefaultCardStyle.',
        );
        expect(
          middleForeground,
          Colors.red,
          reason: 'Middle foreground should be overridden by RedForegroundCardStyle.',
        );
        expect(
          background,
          Colors.red,
          reason: 'Inner background should be overridden by RedBackgroundCardStyle.',
        );
        expect(
          foreground,
          Colors.red,
          reason: 'Inner foreground should be overridden by RedForegroundCardStyle.',
        );
      });
    });

    group('Rebuild behavior', () {
      testWidgets("doesn't trigger rebuild for widgets that don't depend on changed styles",
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

        expect(buildCount, equals(1), reason: 'Initial build should occur once.');

        await tester.pumpWidget(
          MultiTheme(
            themes: const [
              CardTheme(style: RedBackgroundCardStyle.new),
              FontTheme(style: BigFontStyle.new),
            ],
            child: child,
          ),
        );

        expect(
          buildCount,
          equals(1),
          reason: 'Rebuild should not occur if cardTheme remains unchanged.',
        );
      });
    });
  });
}
