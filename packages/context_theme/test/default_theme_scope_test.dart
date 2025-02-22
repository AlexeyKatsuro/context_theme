import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' hide CardTheme;
import 'package:flutter_test/flutter_test.dart';

import 'themes/card_theme.dart';
import 'themes/text_theme.dart';

void main() {
  testWidgets('should provider default style if no theme ancestors', (tester) async {
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

  testWidgets('should throw execution if no theme ancestors and no DefaultThemeScope',
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

  testWidgets('should provider default style for different themes for the same context',
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

  testWidgets('should returns the same instance for multiple theme accesses in the same context',
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

    expect(identical(cardStyle1, cardStyle2), isTrue);
  });

  testWidgets('should retains the same theme instance after rebuilding DefaultThemeScope',
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

    await tester.pump();

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

    expect(identical(cardStyle1, cardStyle2), isTrue);
  });

  testWidgets('links should use bottom style', (tester) async {
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
}
