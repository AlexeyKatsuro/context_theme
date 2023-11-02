import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

part 'style_element.dart';

typedef CreateStyle<S extends Style> = S Function();

abstract class WidgetTheme<S extends Style> extends InheritedWidget {
  /// Initializes [key] for subclasses.
  const WidgetTheme({super.key, required this.createStyle, required super.child});

  static S styleOf<S extends Style, W extends WidgetTheme<S>>(BuildContext context) {
    var targetContext = context;
    if (targetContext is StyleElement && targetContext.widget.runtimeType == W) {
      Element? parent;
      targetContext.visitAncestorElements((element) {
        parent = element;
        return false;
      });
      if (parent != null) {
        targetContext = parent!;
      }
    }
    final styleElement = targetContext.getElementForInheritedWidgetOfExactType<W>() as StyleElement;

    if (!styleElement.doesHasDepended(context)) {
      context.dependOnInheritedElement(styleElement);
    }
    return styleElement.getStyle(context) as S;
  }

  /// Creates a [StyleElement] to manage this widget's location in the tree.
  ///
  /// It is uncommon for subclasses to override this method.
  @override
  StyleElement createElement() => StyleElement(this);

  @protected
  final CreateStyle<S> createStyle;

  @override
  bool updateShouldNotify(covariant WidgetTheme oldWidget) => oldWidget.createStyle != createStyle;
}

@optionalTypeArgs
abstract class Style with Diagnosticable {
  /// The current configuration.
  ///
  /// A [Style] object's configuration is the corresponding [StatefulWidget]
  /// instance. This property is initialized by the framework before calling
  /// [initState]. If the parent updates this location in the tree to a new
  /// widget with the same [runtimeType] and [Widget.key] as the current
  /// configuration, the framework will update this property to refer to the new
  /// widget and then call [didUpdateWidget], passing the old configuration as
  /// an argument.
  WidgetTheme get widget => _widget!;
  WidgetTheme? _widget;

  /// The location in the tree where this widget builds.
  ///
  /// The framework associates [Style] objects with a [BuildContext] after
  /// creating them with [StatefulWidget.createState] and before calling
  /// [initState]. The association is permanent: the [Style] object will never
  /// change its [BuildContext]. However, the [BuildContext] itself can be moved
  /// around the tree.
  ///
  /// After calling [_dispose], the framework severs the [Style] object's
  /// connection with the [BuildContext].
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

  Element? _hostElement;

  Element? _element;

  @protected
  BuildContext get parent {
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
