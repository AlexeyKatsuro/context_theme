import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MaterialStateScope extends ChangeNotifierProvider<MaterialStatesController> {
  MaterialStateScope({
    super.key,
    required MaterialStatesController states,
    required Widget super.child,
  }) : super.value(value: states);
}

extension MaterialStateScopeExt on BuildContext {
  bool containsStates(Set<MaterialState> materialStates) {
    return select<MaterialStatesController, bool>(
        (states) => states.value.containsAll(materialStates),);
  }

  bool get isInteractive => !isDisabled;

  bool get isDisabled => containsStates(const {MaterialState.disabled});

  bool get isDragged => containsStates(const {MaterialState.dragged});

  bool get isError => containsStates(const {MaterialState.error});

  bool get isFocused => containsStates(const {MaterialState.focused});

  bool get isHovered => containsStates(const {MaterialState.hovered});

  bool get isPressed => containsStates(const {MaterialState.pressed});

  bool get isSelected => containsStates(const {MaterialState.selected});
}
