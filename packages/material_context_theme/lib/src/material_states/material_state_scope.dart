import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class MaterialStateScope extends InheritedModel<MaterialState> {
  const MaterialStateScope({
    super.key,
    required super.child,
    required this.states,
  });

  static Widget controller({
    required Widget child,
    required MaterialStatesController controller,
  }) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, states, child) {
        return MaterialStateScope(
          states: {...states},
          child: child!,
        );
      },
      child: child,
    );
  }

  final Set<MaterialState> states;

  @override
  bool updateShouldNotify(covariant MaterialStateScope oldWidget) {
    return !const SetEquality<MaterialState>().equals(states, oldWidget.states);
  }

  @override
  bool updateShouldNotifyDependent(
    covariant MaterialStateScope oldWidget,
    Set<MaterialState> dependencies,
  ) {
    for (final dependency in dependencies) {
      if (states.contains(dependency) != oldWidget.states.contains(dependency)) {
        return true;
      }
    }
    return false;
  }

  static bool contains(BuildContext context, MaterialState state) {
    return InheritedModel.inheritFrom<MaterialStateScope>(context, aspect: state)
            ?.states
            .contains(state) ??
        false;
  }
}

extension MaterialStateScopeExt on BuildContext {
  bool get isInteractive => !isDisabled;

  bool get isDisabled => MaterialStateScope.contains(this, MaterialState.disabled);

  bool get isDragged => MaterialStateScope.contains(this, MaterialState.dragged);

  bool get isError => MaterialStateScope.contains(this, MaterialState.error);

  bool get isFocused => MaterialStateScope.contains(this, MaterialState.focused);

  bool get isHovered => MaterialStateScope.contains(this, MaterialState.hovered);

  bool get isPressed => MaterialStateScope.contains(this, MaterialState.pressed);

  bool get isSelected => MaterialStateScope.contains(this, MaterialState.selected);
}
