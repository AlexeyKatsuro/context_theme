import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'single_inherited_widget.dart';

part 'context_theme_element.dart';

part 'default_theme_scope.dart';

part 'default_theme_scope_element.dart';

typedef CreateStyle<S extends Style> = S Function();

typedef StyleOf<S extends Style> = S Function(BuildContext context, [StyleOwnerContext? parent]);

typedef StyleOfContext<S extends Style> = S Function(BuildContext context);

abstract class ContextTheme<S extends Style, T extends ContextTheme<S, T>>
    extends SingleChildInheritedWidget {
  const ContextTheme({
    super.key,
    required S Function() style,
    super.child,
    required StyleOf<S> styleOf,
  })  : _createStyle = style,
        _styleOf = styleOf;

  final StyleOf<S> _styleOf;

  static S styleOf<S extends Style, T extends ContextTheme<S, T>>(
    BuildContext context, {
    StyleOwnerContext? inheritFrom,
    required CreateStyle<S> defaultStyle,
  }) {
    StyleOwnerContext? styleOwner;

    if (inheritFrom != null) {
      styleOwner = inheritFrom.getParentStyleOwner<S, T>();
    } else {
      styleOwner = context.getElementForInheritedWidgetOfExactType<T>() as StyleOwnerContext?;
    }
    styleOwner ??=
        context.getElementForInheritedWidgetOfExactType<DefaultThemeScope>() as StyleOwnerContext?;

    if (styleOwner == null) {
      throw StyleNullException(T, context.widget.runtimeType, S);
    }

    if (!styleOwner.doesHasDepended<S, T>(context)) {
      context.dependOnInheritedElement(
        styleOwner,
        aspect: _DefaultThemeAspect<S, T>(defaultStyle),
      );
    }
    return styleOwner._getStyle<S, T>(context);
  }

  @override
  ContextThemeElement createElement() => ContextThemeElement(this);

  @protected
  final CreateStyle<S> _createStyle;

  @override
  bool updateShouldNotify(covariant ContextTheme oldWidget) =>
      oldWidget._createStyle != _createStyle;

  S _link(S style) => _styleOf.call(style.context);

  S _inherit(S style) => _styleOf(style.context, style.parent);
}

@optionalTypeArgs
abstract class Style with Diagnosticable {
  ContextTheme get widget => _widget!;
  ContextTheme? _widget;

  @protected
  Style get link {
    _assetMounted();
    return _widget?._link(this) ?? this;
  }

  @protected
  Style get inherit {
    _assetMounted();
    return _widget!._inherit(this);
  }

  BuildContext get context {
    _assetMounted();
    return _dependentElement!;
  }

  bool _disposed = false;

  StyleOwnerContext? _hostElement;

  Element? _dependentElement;

  StyleOwnerContext get parent {
    _assetMounted();
    return _hostElement!;
  }

  void _mound(Element dependent, StyleOwnerContext hostElement) {
    _dependentElement = dependent;
    _hostElement = hostElement;
  }

  void _dispose() {
    _disposed = true;
  }

  void _assetMounted() {
    assert(() {
      if (_dependentElement == null || _hostElement == null) {
        throw FlutterError(
          "This widget hasn't been mounted, so the Style has no a context or parent (and should be considered defunct).\n",
        );
      }
      if (_disposed) {
        throw FlutterError('Style was disposed');
      }
      return true;
    }());
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<ContextTheme>('_widget', _widget, ifNull: 'no widget'));
    properties
        .add(ObjectFlagProperty<Element>('_element', _dependentElement, ifNull: 'not mounted'));
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
