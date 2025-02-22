import 'package:context_theme/context_theme.dart';
import 'package:flutter/material.dart' hide CardTheme;
import 'package:flutter_test/flutter_test.dart';

import 'themes/card_theme.dart';
import 'themes/variant_card_theme.dart';

void main() {
  testWidgets('should merge styles with MultiTheme', (tester) async {
    Color? background;
    Color? foreground;
    Color? variantBackground;
    Color? variantForeground;
    TextStyle? textStyle;
    TextStyle? variantTextStyle;
    await tester.pumpWidget(
      DefaultThemeScope(
        child: MultiTheme(
          themes: const [
            CardTheme(style: RedBackgroundCardStyle.new),
            VariantCardTheme(style: RedForegroundCardStyle.new),
          ],
          child: Builder(
            builder: (context) {
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

    expect(background, RedBackgroundCardStyleMixin.kBackground);
    expect(foreground, DefaultCardStyle.kForeground); // default
    expect(variantBackground, DefaultVariantCardStyle.kBackground); // default of VariantCardTheme
    expect(variantForeground, RedForegroundCardStyleMixin.kForeground);
    expect(textStyle?.color, foreground);
    expect(variantTextStyle?.color, variantForeground);
  });

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
    expect(textStyle?.color, DefaultVariantCardStyle.kForeground);
  });

  // TOOD Handle this case
  testWidgets('base inherit type should able to use link from variant descendant type',
      (tester) async {
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
    expect(variantTextStyle?.color, RedForegroundCardStyleMixin.kForeground);
    expect(textStyle?.color, DefaultCardStyle.kForeground);

  });
}
