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
              variantBackground = context.variantCardTheme.background;
              variantForeground = context.variantCardTheme.foreground;
              variantTextStyle = context.variantCardTheme.textStyle;
              return const SizedBox();
            },
          ),
        ),
      ),
    );

    expect(background, Colors.red);
    expect(foreground, Colors.black); // default
    expect(variantBackground, Colors.white70); // default of VariantCardTheme
    expect(variantForeground, Colors.red);
    expect(variantTextStyle, const TextStyle(fontSize: 14)); // inherit from CardTheme
  });
}
