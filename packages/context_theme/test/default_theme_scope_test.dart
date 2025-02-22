import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' hide CardTheme;
import 'package:flutter_test/flutter_test.dart';

import 'themes/card_theme.dart';
import 'themes/text_theme.dart';

void main() {
  group('ContextTheme with DefaultThemeScope', () {
    group('Default style behavior', () {
      testWidgets('provides default style if no theme ancestors are present', (tester) async {
        CardStyle? cardStyle;

        await tester.pumpWidget(
          DefaultThemeScope(
            child: Builder(
              builder: (context) {
                cardStyle = context.cardTheme;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(cardStyle, isA<DefaultCardStyle>());
      });

      testWidgets('provides default style for different themes within the same context',
          (tester) async {
        CardStyle? cardStyle;
        FontStyle? fontStyle;

        await tester.pumpWidget(
          DefaultThemeScope(
            child: Builder(
              builder: (context) {
                cardStyle = context.cardTheme;
                fontStyle = context.fontTheme;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(cardStyle, isA<DefaultCardStyle>());
        expect(fontStyle, isA<DefaultFontStyle>());
      });
    });

    group('Theme instance behavior', () {
      testWidgets('returns the same instance for multiple theme accesses in the same context',
          (tester) async {
        CardStyle? cardStyle1;
        CardStyle? cardStyle2;

        await tester.pumpWidget(
          DefaultThemeScope(
            child: Builder(
              builder: (context) {
                cardStyle1 = context.cardTheme;
                cardStyle2 = context.cardTheme;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(cardStyle1, same(cardStyle2));
      });

      testWidgets('retains the same theme instance after rebuilding DefaultThemeScope',
          (tester) async {
        CardStyle? cardStyle1;
        CardStyle? cardStyle2;

        await tester.pumpWidget(
          DefaultThemeScope(
            child: Builder(
              builder: (context) {
                cardStyle1 = context.cardTheme;
                return const SizedBox();
              },
            ),
          ),
        );

        await tester.pump(); // Force a frame rebuild

        await tester.pumpWidget(
          DefaultThemeScope(
            child: Builder(
              builder: (context) {
                cardStyle2 = context.cardTheme;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(cardStyle1, same(cardStyle2));
      });
    });

    group('Exception handling', () {
      testWidgets('throws exception if accessed without theme ancestor or DefaultThemeScope',
          (tester) async {
        await tester.pumpWidget(
          Builder(
            builder: (context) {
              return const SizedBox();
            },
          ),
        );

        expect(
          () => tester.element(find.byType(SizedBox)).cardTheme,
          throwsA(isA<StyleNullException>()),
        );
      });
    });

    group('Style inheritance', () {
      testWidgets('applies style from the nearest theme ancestor', (tester) async {
        TextStyle? textStyle;

        await tester.pumpWidget(
          DefaultThemeScope(
            child: CardTheme(
              style: RedForegroundCardStyle.new,
              child: Builder(
                builder: (context) {
                  textStyle = context.cardTheme.textStyle;
                  return const SizedBox();
                },
              ),
            ),
          ),
        );

        expect(textStyle?.color, Colors.red);
      });
    });
  });
}
