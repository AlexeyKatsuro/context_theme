import 'package:flutter/widgets.dart';

typedef DecorateWrapper = Widget Function(BuildContext context, Widget child);

extension DecorateWrapperApply on DecorateWrapper? {
  Widget apply({required WidgetBuilder builder}) {
    final decorator = this;
    final child = Builder(builder: builder);
    if (decorator == null) return child;
    return Builder(
      builder: (context) {
        return decorator(context, child);
      },
    );
  }

  DecorateWrapper wrap({required DecorateWrapper decorator}) {
    final parentDecorator = this;
    return (context, child) {
      final decoratedChild = Builder(
        builder: (context) => decorator(context, child),
      );
      return parentDecorator != null ? parentDecorator(context, decoratedChild) : decoratedChild;
    };
  }
}
