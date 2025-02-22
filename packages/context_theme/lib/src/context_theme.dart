import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'single_inherited_widget.dart';

part 'context_theme_element.dart';
part 'default_theme_scope.dart';
part 'default_theme_scope_element.dart';

typedef CreateStyle<S extends Style> = S Function();

mixin StyleOfContext<S extends Style> {
  S call(BuildContext context, {StyleOwnerContext? inheritFrom});
}

@immutable
class StyleOf<S extends Style, T extends ContextTheme<S, T>> with StyleOfContext<S> {
  const StyleOf({required this.defaultStyle});

  final CreateStyle<S> defaultStyle;

  Type get themeType => T;

  Type get styleType => S;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StyleOf && runtimeType == other.runtimeType && defaultStyle == other.defaultStyle;

  @override
  int get hashCode => defaultStyle.hashCode;

  @override
  S call(
    BuildContext context, {
    StyleOwnerContext? inheritFrom,
    StyleOf<S, ContextTheme<S, dynamic>>? linkTo,
  }) {
    {
      StyleOwnerContext? styleOwner;

      if (inheritFrom != null) {
        styleOwner = inheritFrom.getParentStyleOwner<S, T>();
      } else {
        styleOwner = context.getElementForInheritedWidgetOfExactType<T>() as StyleOwnerContext?;
      }
      styleOwner ??= context.getElementForInheritedWidgetOfExactType<DefaultThemeScope>()
          as StyleOwnerContext?;

      if (styleOwner == null) {
        throw StyleNullException(T, context.widget.runtimeType, S);
      }

      final aspect = _ThemeAspect<S, T>(styleOf: this, linkTo: linkTo);
      context.dependOnInheritedElement(styleOwner, aspect: aspect);

      return styleOwner._getStyle<S, T>(context, aspect);
    }
  }
}

abstract class ContextTheme<S extends Style, T extends ContextTheme<S, T>>
    extends SingleChildInheritedWidget {
  const ContextTheme({
    super.key,
    required S Function() style,
    super.child,
  })  : _createStyle = style;


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

  StyleOf? _styleOf;
  StyleOf? _linkTo;

  StyleOf? get inheritFrom => null;

  @protected
  Style get link {
    _assetMounted();
    return _linkTo?.call(context) ?? this;
  }

  @protected
  Style get inherit {
    _assetMounted();
    final inheritFrom = _widget != null ? _styleOf : this.inheritFrom;
    assert(inheritFrom != null, "TODO");

    final linkTo = (_linkTo ?? _styleOf)!;
    return inheritFrom!(
      context,
      inheritFrom: _widget != null ? parent : null,
      linkTo: linkTo,
    );
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

mixin TypedStyle<S extends Style> on Style {
  @override
  S get link => super.link as S;

  @override
  S get inherit => super.inherit as S;
}

mixin InheritStyle<S extends Style> on TypedStyle<S> {
  @override
  StyleOf<S, ContextTheme<S, dynamic>> get inheritFrom;
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
