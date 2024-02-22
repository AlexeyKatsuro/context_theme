import 'package:flutter/material.dart' hide CardTheme;
import 'package:flutter_test/flutter_test.dart';

import 'themes/card_theme.dart';

void main() {
  group('ContextTheme.styleOf', () {
    testWidgets('should provider style', (tester) async {
      CardStyle? style;
      await tester.pumpWidget(
        CardTheme(
          style: RedBackgroundCardStyle.new,
          child: Builder(
            builder: (context) {
              style = context.cardTheme;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(style, isA<RedBackgroundCardStyle>());
      expect(style?.background, Colors.red);
    });

    testWidgets('should return style of the closest theme ancestor to invocation context',
        (tester) async {
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

    testWidgets(
      "shouldn't trigger rebuild if style wasn't changed",
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
      },
    );

    testWidgets(
      'should trigger rebuild if style was changed',
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
      },
    );
  });
}
