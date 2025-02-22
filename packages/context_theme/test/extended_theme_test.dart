import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' hide CardTheme;
import 'package:flutter_test/flutter_test.dart';

import 'themes/card_theme.dart';
import 'themes/extended_card_theme.dart';

void main() {
  group('ExtendedCardTheme', () {
    testWidgets('should provide default style if no theme ancestors', (tester) async {
      ExtendedCardStyle? extendedStyle;

      await tester.pumpWidget(
        DefaultThemeScope(
          child: Builder(
            builder: (context) {
              extendedStyle = context.extendedCardTheme;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(extendedStyle, isA<DefaultExtendedCardStyle>());
    });

    testWidgets('should throw exception if no ExtendedCardTheme and no DefaultThemeScope',
        (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            return const SizedBox();
          },
        ),
      );

      expect(
        () => tester.element(find.byType(SizedBox)).extendedCardTheme,
        throwsA(isA<StyleNullException>()),
      );
    });

    testWidgets('should return correct default shape and side values', (tester) async {
      OutlinedBorder? shape;
      BorderSide? side;

      await tester.pumpWidget(
        DefaultThemeScope(
          child: Builder(
            builder: (context) {
              shape = context.extendedCardTheme.shape;
              side = context.extendedCardTheme.side;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(shape, isA<RoundedRectangleBorder>());
      expect(side, isNotNull);
    });

    testWidgets('should inherit StadiumCard style from the closest theme', (tester) async {
      OutlinedBorder? shape;

      await tester.pumpWidget(
        DefaultThemeScope(
          child: ExtendedCardTheme(
            style: StadiumCard.new,
            child: Builder(
              builder: (context) {
                shape = context.extendedCardTheme.shape;
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(shape, isA<StadiumBorder>());
    });
  });

  group('CardTheme and ExtendedCardTheme interaction', () {
    testWidgets('should allow inheriting and linking to origin style', (tester) async {
      late OutlinedBorder inheritedShape;
      late Color foreground;

      await tester.pumpWidget(
        DefaultThemeScope(
          child: Builder(
            builder: (context) {
              inheritedShape = context.extendedCardTheme.shape;
              foreground = context.extendedCardTheme.foreground;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(
        inheritedShape,
        isA<RoundedRectangleBorder>()
            .having((shape) => shape.side.color, 'side.color', equals(foreground)),
        reason: 'side color linked to foreground',
      );
      expect(
        foreground,
        equals(DefaultCardStyle.kForeground),
        reason: 'foreground inherited from DefaultCardTheme',
      );
    });

    testWidgets('should work correctly when both CardTheme and ExtendedCardTheme are used',
        (tester) async {
      CardStyle? cardStyle;
      ExtendedCardStyle? extendedStyle;

      await tester.pumpWidget(
        DefaultThemeScope(
          child: Builder(
            builder: (context) {
              cardStyle = context.cardTheme;
              extendedStyle = context.extendedCardTheme;
              expect(context.cardTheme, same(cardStyle));
              expect(context.extendedCardTheme, same(extendedStyle));
              return const SizedBox();
            },
          ),
        ),
      );

      expect(cardStyle, isA<DefaultCardStyle>());
      expect(extendedStyle, isA<DefaultExtendedCardStyle>());
    });

    testWidgets('should merge CardTheme and ExtendedCardTheme with MultiTheme', (tester) async {
      CardStyle? cardStyle;
      ExtendedCardStyle? extendedStyle;

      await tester.pumpWidget(
        DefaultThemeScope(
          child: MultiTheme(
            themes: const [
              CardTheme(style: RedForegroundCardStyle.new),
              ExtendedCardTheme(style: RedBackgroundExtendedCardStyle.new),
            ],
            child: Builder(
              builder: (context) {
                cardStyle = context.cardTheme;
                extendedStyle = context.extendedCardTheme;
                expect(cardStyle?.foreground, RedForegroundCardStyleMixin.kForeground);
                expect(extendedStyle?.background, RedBackgroundCardStyleMixin.kBackground);
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(cardStyle, isA<RedForegroundCardStyle>());
      expect(extendedStyle, isA<RedBackgroundExtendedCardStyle>());
    });
  });
}
