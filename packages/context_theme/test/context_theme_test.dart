import 'package:flutter/material.dart' hide CardTheme;
import 'package:flutter_test/flutter_test.dart';

import 'themes/card_theme.dart';

void main() {
  group('ContextTheme.styleOf', () {
    group('Basic behavior', () {
      testWidgets('provides the correct style from the closest theme ancestor', (tester) async {
        CardStyle? styleDeep1;
        CardStyle? styleDeep2;

        await tester.pumpWidget(
          CardTheme(
            style: RedForegroundCardStyle.new,
            child: Builder(
              builder: (context) {
                styleDeep1 = context.cardTheme;
                return CardTheme(
                  style: RedBackgroundCardStyle.new,
                  child: Builder(
                    builder: (context) {
                      styleDeep2 = context.cardTheme;
                      return const SizedBox();
                    },
                  ),
                );
              },
            ),
          ),
        );

        expect(styleDeep1, isA<RedForegroundCardStyle>());
        expect(styleDeep2, isA<RedBackgroundCardStyle>());
      });

      testWidgets('returns the same instance for multiple accesses in the same context',
          (tester) async {
        CardStyle? cardStyle1;
        CardStyle? cardStyle2;

        await tester.pumpWidget(
          CardTheme(
            style: DefaultCardStyle.new,
            child: Builder(
              builder: (context) {
                cardStyle1 = context.cardTheme;
                cardStyle2 = context.cardTheme;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(identical(cardStyle1, cardStyle2), isTrue);
      });

      testWidgets('returns the same instance after rebuild within the same context',
          (tester) async {
        CardStyle? cardStyle1;
        CardStyle? cardStyle2;

        await tester.pumpWidget(
          CardTheme(
            style: DefaultCardStyle.new,
            child: Builder(
              builder: (context) {
                cardStyle1 = context.cardTheme;
                return const SizedBox();
              },
            ),
          ),
        );

        await tester.pumpWidget(
          CardTheme(
            style: DefaultCardStyle.new,
            child: Builder(
              builder: (context) {
                cardStyle2 = context.cardTheme;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(identical(cardStyle1, cardStyle2), isTrue);
      });
    });

    group('Rebuild behavior', () {
      testWidgets('does not trigger rebuild if style remains unchanged', (tester) async {
        var buildCount = 0;

        final child = Builder(
          builder: (context) {
            context.cardTheme;
            buildCount++;
            return const SizedBox();
          },
        );

        await tester.pumpWidget(
          CardTheme(
            style: RedBackgroundCardStyle.new,
            child: child,
          ),
        );

        expect(buildCount, equals(1));

        await tester.pumpWidget(
          CardTheme(
            style: RedBackgroundCardStyle.new,
            child: child,
          ),
        );

        expect(buildCount, equals(1));
      });

      testWidgets('triggers rebuild when style changes', (tester) async {
        var buildCount = 0;

        final child = Builder(
          builder: (context) {
            context.cardTheme;
            buildCount++;
            return const SizedBox();
          },
        );

        await tester.pumpWidget(
          CardTheme(
            style: RedBackgroundCardStyle.new,
            child: child,
          ),
        );

        expect(buildCount, equals(1));

        await tester.pumpWidget(
          CardTheme(
            style: RedForegroundCardStyle.new,
            child: child,
          ),
        );

        expect(buildCount, equals(2));
      });

      testWidgets('updates context.cardTheme when style changes', (tester) async {
        late CardStyle cardStyle1;
        late CardStyle cardStyle2;

        await tester.pumpWidget(
          CardTheme(
            style: RedBackgroundCardStyle.new,
            child: Builder(
              builder: (context) {
                cardStyle1 = context.cardTheme;
                return const SizedBox();
              },
            ),
          ),
        );

        await tester.pumpWidget(
          CardTheme(
            style: RedForegroundCardStyle.new,
            child: Builder(
              builder: (context) {
                cardStyle2 = context.cardTheme;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(cardStyle1, isA<RedBackgroundCardStyle>());
        expect(cardStyle2, isA<RedForegroundCardStyle>());
      });
    });

    group('Mixin behavior', () {
      testWidgets('MixinOverlayTextStyle overrides foreground but inherits other properties',
          (tester) async {
        late CardStyle cardStyle;

        await tester.pumpWidget(
          CardTheme(
            style: MixinOverlayCardStyle.new,
            child: Builder(
              builder: (context) {
                cardStyle = context.cardTheme;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(
          cardStyle.foreground,
          equals(MixinOverlayCardStyle.kForeground),
          reason: 'Foreground should be overridden by MixinOverlayTextStyle.',
        );

        expect(
          cardStyle.background,
          equals(RedBackgroundCardStyleMixin.kBackground),
          reason: 'Background should be inherited from RedBackgroundCardStyleMixin.',
        );

        expect(
          cardStyle.textStyle?.color,
          equals(MixinOverlayCardStyle.kForeground),
          reason: 'Text color should be set based on link.foreground, which is overridden.',
        );

        expect(
          cardStyle.textStyle?.fontSize,
          equals(SmallTextCardStyleMixin.kFontSize),
        );
      });
    });
  });
}
