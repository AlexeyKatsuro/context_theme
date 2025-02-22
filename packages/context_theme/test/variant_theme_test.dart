import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' hide CardTheme;
import 'package:flutter_test/flutter_test.dart';

import 'themes/card_theme.dart';
import 'themes/variant_card_theme.dart';

void main() {
  group('VariantCardTheme and MultiTheme', () {
    group('Style merging behavior', () {
      testWidgets('merges styles with MultiTheme', (tester) async {
        Color? background;
        Color? foreground;
        Color? variantBackground;
        Color? variantForeground;
        TextStyle? textStyle;
        TextStyle? variantTextStyle;
        CardStyle? cardTheme;
        CardStyle? variantCardTheme;

        await tester.pumpWidget(
          DefaultThemeScope(
            child: MultiTheme(
              themes: const [
                CardTheme(style: RedBackgroundCardStyle.new),
                VariantCardTheme(style: RedForegroundCardStyle.new),
              ],
              child: Builder(
                builder: (context) {
                  cardTheme = context.cardTheme;
                  variantCardTheme = context.variantCardTheme;
                  background = context.cardTheme.background;
                  foreground = context.cardTheme.foreground;
                  textStyle = context.cardTheme.textStyle;
                  variantBackground = context.variantCardTheme.background;
                  variantForeground = context.variantCardTheme.foreground;
                  variantTextStyle = context.variantCardTheme.textStyle;
                  return const SizedBox();
                },
              ),
            ),
          ),
        );

        expect(
          cardTheme,
          isA<RedBackgroundCardStyle>(),
        );
        expect(
          variantCardTheme,
          isA<RedForegroundCardStyle>(),
        );
        expect(
          background,
          RedBackgroundCardStyleMixin.kBackground,
          reason: 'CardTheme should take background from RedBackgroundCardStyle.',
        );
        expect(
          foreground,
          DefaultCardStyle.kForeground,
          reason: 'Foreground should use DefaultCardStyle as it is not overridden.',
        );
        expect(
          variantBackground,
          DefaultVariantCardStyle.kBackground,
          reason: 'VariantCardTheme should use its default background.',
        );
        expect(
          variantForeground,
          RedForegroundCardStyleMixin.kForeground,
          reason: 'VariantCardTheme should take foreground from RedForegroundCardStyle.',
        );
        expect(
          textStyle?.color,
          foreground,
          reason: 'CardTheme text style should inherit color from its foreground.',
        );
        expect(
          variantTextStyle?.color,
          variantForeground,
          reason: 'VariantCardTheme text style should inherit color from its foreground.',
        );
      });
    });

    group('Inheritance behavior', () {
      testWidgets('links should be inherited', (tester) async {
        TextStyle? textStyle;

        await tester.pumpWidget(
          DefaultThemeScope(
            child: CardTheme(
              style: RedForegroundCardStyle.new,
              child: Builder(
                builder: (context) {
                  textStyle = context.variantCardTheme.textStyle;
                  return const SizedBox();
                },
              ),
            ),
          ),
        );

        expect(
          textStyle?.color,
          DefaultVariantCardStyle.kForeground,
          reason: 'VariantCardTheme should inherit default foreground color.',
        );
      });

      testWidgets('base inherit type should use link from variant descendant type', (tester) async {
        TextStyle? variantTextStyle;
        TextStyle? textStyle;

        await tester.pumpWidget(
          DefaultThemeScope(
            child: Builder(
              builder: (context) {
                return VariantCardTheme(
                  style: RedForegroundCardStyle.new,
                  child: Builder(
                    builder: (context) {
                      variantTextStyle = context.variantCardTheme.textStyle;
                      textStyle = context.cardTheme.textStyle;
                      return const SizedBox();
                    },
                  ),
                );
              },
            ),
          ),
        );

        expect(
          variantTextStyle?.color,
          RedForegroundCardStyleMixin.kForeground,
          reason: 'VariantCardTheme should use RedForegroundCardStyleMixin.kForeground.',
        );
        expect(
          textStyle?.color,
          DefaultCardStyle.kForeground,
          reason: 'CardTheme should still use DefaultCardStyle.kForeground.',
        );
      });
    });
  });
}
