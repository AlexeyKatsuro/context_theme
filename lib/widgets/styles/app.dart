/*
import 'package:attr_theme/widgets/styles/button.dart';
import 'package:attr_theme/widgets/styles/buttons/theme.dart';
import 'package:attr_theme/widgets/styles/colors_styles.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  const ColorsTheme(
      createStyle: DefaultColorsStyle.new,
      child: TypographyTheme(
        createStyle: TypographyStyle.new,
        child: ButtonTheme(
          createStyle: ButtonStyle.new,
          child: Screen(),
        ),
      ),
    );
  }
}

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Button(
          child: Text('text'),
        ),

        ButtonTheme(
          createStyle: PrimaryButtonStyle.new,
          child: Button(
            child: Text('text'),
          ),
        ),
      ],
    );
  }
}
*/
