import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'single_inherited_widget.dart';

part 'context_theme_element.dart';
part 'default_theme_scope.dart';
part 'default_theme_scope_element.dart';

typedef CreateStyle<S extends Style> = S Function();

abstract class ContextTheme<S extends Style> extends SingleChildInheritedWidget {
  const ContextTheme({super.key, required S Function() style, super.child}) : _createStyle = style;

  static StyleType styleOf<StyleType extends Style, W extends ContextTheme<StyleType>>(
    BuildContext context, {
    StyleOwnerContext? inheritFrom,
    required CreateStyle<StyleType> defaultStyle,
  }) {
    StyleOwnerContext? styleOwner;

    if (inheritFrom != null) {
      styleOwner = inheritFrom.getParentStyleOwner<W>();
    } else {
      styleOwner = context.getElementForInheritedWidgetOfExactType<W>() as StyleOwnerContext?;
    }
    styleOwner ??=
        context.getElementForInheritedWidgetOfExactType<DefaultThemeScope>() as StyleOwnerContext?;

    if (styleOwner == null) {
      throw StyleNullException(W, context.widget.runtimeType, StyleType);
    }

    if (!styleOwner.doesHasDepended(context)) {
      context.dependOnInheritedElement(
        styleOwner,
        aspect: _DefaultThemeAspect<StyleType>(defaultStyle),
      );
    }
    return styleOwner._getStyle<StyleType>(context);
  }

  @override
  ContextThemeElement createElement() => ContextThemeElement(this);

  @protected
  final CreateStyle<S> _createStyle;

  @override
  bool updateShouldNotify(covariant ContextTheme oldWidget) =>
      oldWidget._createStyle != _createStyle;
}

@optionalTypeArgs
abstract class Style with Diagnosticable {
  ContextTheme get widget => _widget!;
  ContextTheme? _widget;

  BuildContext get context {
    assert(() {
      if (_element == null) {
        throw FlutterError(
          "This widget hasn't been mounted, so the Style no longer has a context (and should be considered defunct). \n"
        );
      }
      if (_disposed) {
        throw FlutterError('Style was disposed');
      }
      return true;
    }());
    return _element!;
  }

  bool _disposed = false;

  StyleOwnerContext? _hostElement;

  Element? _element;

  @protected
  StyleOwnerContext get parent {
    assert(_hostElement != null);
    return _hostElement!;
  }

  void _dispose() {
    _disposed = true;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<ContextTheme>('_widget', _widget, ifNull: 'no widget'));
    properties.add(ObjectFlagProperty<Element>('_element', _element, ifNull: 'not mounted'));
    properties
        .add(ObjectFlagProperty<Element>('_hostElement', _hostElement, ifNull: 'Has not parent'));
  }
}

class StyleNullException implements Exception {
  /// Create a StyleNullException error with the type represented as a String.
  StyleNullException(this.widgetThemeType, this.callerType, this.stateType);

  final Type widgetThemeType;
  final Type callerType;
  final Type stateType;

  @override
  String toString() {
    if (kReleaseMode) {
      return 'A ContextTheme for $widgetThemeType unexpectedly returned null.';
    }
    return '''
Error: The widget $callerType tried to read ContextTheme.styleOf<$stateType, $widgetThemeType> but widget has no parent theme of $widgetThemeType.
And there is no DefaultThemeScope.

Consider using DefaultThemeScope as a top widget.
''';
  }
}

