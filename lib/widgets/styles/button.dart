import 'package:attr_theme/widgets/styles/buttons/theme.dart';
import 'package:flutter/widgets.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final style = context.buttonStyle;
    return Container(
      decoration: ShapeDecoration(
        color: style.backgroundColor,
        shape: style.shape,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:12.0, vertical: 8.0),
        child: DefaultTextStyle.merge(
          child: child,
          style: TextStyle(color: style.foregroundColor)
        ),
      ),
    );
  }
}
