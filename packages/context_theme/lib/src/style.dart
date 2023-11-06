import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

import 'single_inherited_widget.dart';

part 'default_theme_scope.dart';
part 'default_theme_scope_element.dart';
part 'style_element.dart';

typedef CreateStyle<S extends Style> = S Function();

abstract class WidgetTheme<S extends Style> extends SingleChildInheritedWidget {
  /// Initializes [key] for subclasses.
  const WidgetTheme({super.key, required S Function() style, super.child}) : _createStyle = style;

  static StyleType styleOf<StyleType extends Style, W extends WidgetTheme<StyleType>>(
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

  /// Creates a [StyleElement] to manage this widget's location in the tree.
  ///
  /// It is uncommon for subclasses to override this method.
  @override
  StyleElement createElement() => StyleElement(this);

  @protected
  final CreateStyle<S> _createStyle;

  @override
  bool updateShouldNotify(covariant WidgetTheme oldWidget) =>
      oldWidget._createStyle != _createStyle;
}

@optionalTypeArgs
abstract class Style with Diagnosticable {
  WidgetTheme get widget => _widget!;
  WidgetTheme? _widget;

  BuildContext get context {
    assert(() {
      if (_element == null) {
        throw FlutterError(
          'This widget has been unmounted, so the State no longer has a context (and should be considered defunct). \n'
          'Consider canceling any active work during "dispose" or using the "mounted" getter to determine if the State is still active.',
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
    properties.add(ObjectFlagProperty<WidgetTheme>('_widget', _widget, ifNull: 'no widget'));
    properties.add(ObjectFlagProperty<Element>('_element', _element, ifNull: 'not mounted'));
    properties
        .add(ObjectFlagProperty<Element>('_hostElement', _hostElement, ifNull: 'not mounted'));
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
      return 'A WidgetTheme for $widgetThemeType unexpectedly returned null.';
    }
    return '''
Error: The widget $callerType tried to read WidgetTheme.styleOf<$stateType, $widgetThemeType> but widget has no parent theme of $widgetThemeType.
And there is no DefaultThemeScope.

Consider using DefaultThemeScope as a top widget.
''';
  }
}

class MultiTheme extends Nested {
  MultiTheme({
    Key? key,
    required List<SingleChildWidget> themes,
    Widget? child,
  }) : super(
          key: key,
          children: themes,
          child: child,
        );
}
