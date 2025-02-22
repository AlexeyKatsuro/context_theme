import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class MaterialStateScope extends InheritedModel<WidgetState> {
  const MaterialStateScope({
    super.key,
    required super.child,
    required this.states,
  });

  static Widget merge({required Widget child, required Set<WidgetState> states}) {
    return Builder(
      builder: (context) {
        final parentStates =
            InheritedModel.inheritFrom<MaterialStateScope>(context)?.states ?? const {};
        return MaterialStateScope(
          states: {...parentStates, ...states},
          child: child,
        );
      },
    );
  }

  static Widget controller({
    bool? inherit,
    required Widget child,
    required WidgetStatesController controller,
  }) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, states, child) {
        if (inherit ?? true) {
          return MaterialStateScope.merge(
            states: {...states},
            child: child!,
          );
        } else {
          return MaterialStateScope(
            states: {...states},
            child: child!,
          );
        }
      },
      child: child,
    );
  }

  final Set<WidgetState> states;

  @override
  bool updateShouldNotify(covariant MaterialStateScope oldWidget) {
    return !const SetEquality<WidgetState>().equals(states, oldWidget.states);
  }

  @override
  bool updateShouldNotifyDependent(
    covariant MaterialStateScope oldWidget,
    Set<WidgetState> dependencies,
  ) {
    for (final dependency in dependencies) {
      if (states.contains(dependency) != oldWidget.states.contains(dependency)) {
        return true;
      }
    }
    return false;
  }

  static bool contains(BuildContext context, WidgetState state) {
    return InheritedModel.inheritFrom<MaterialStateScope>(context, aspect: state)
            ?.states
            .contains(state) ??
        false;
  }
}

extension MaterialStateScopeExt on BuildContext {
  bool get isInteractive => !isDisabled;

  bool get isDisabled => MaterialStateScope.contains(this, WidgetState.disabled);

  bool get isDragged => MaterialStateScope.contains(this, WidgetState.dragged);

  bool get isError => MaterialStateScope.contains(this, WidgetState.error);

  bool get isFocused => MaterialStateScope.contains(this, WidgetState.focused);

  bool get isHovered => MaterialStateScope.contains(this, WidgetState.hovered);

  bool get isPressed => MaterialStateScope.contains(this, WidgetState.pressed);

  bool get isSelected => MaterialStateScope.contains(this, WidgetState.selected);
}
