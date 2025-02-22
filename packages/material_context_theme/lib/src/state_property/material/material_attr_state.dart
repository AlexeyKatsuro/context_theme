import 'package:flutter/material.dart';

import '../attr_state.dart';

abstract class MaterialAttrState extends AttrState {
  const MaterialAttrState();

  static const HoveredMaterialAttrState hovered = HoveredMaterialAttrState();

  static const FocusedMaterialAttrState focused = FocusedMaterialAttrState();

  static const PressedMaterialAttrState pressed = PressedMaterialAttrState();

  static const DraggedMaterialAttrState dragged = DraggedMaterialAttrState();

  static const SelectedMaterialAttrState selected = SelectedMaterialAttrState();

  static const ScrolledUnderMaterialAttrState scrolledUnder = ScrolledUnderMaterialAttrState();

  static const DisabledMaterialAttrState disabled = DisabledMaterialAttrState();

  static const ErrorMaterialAttrState error = ErrorMaterialAttrState();
}

class HoveredMaterialAttrState extends MaterialAttrState {
  const HoveredMaterialAttrState();

  @override
  String get key => WidgetState.hovered.name;
}

class FocusedMaterialAttrState extends MaterialAttrState {
  const FocusedMaterialAttrState();

  @override
  String get key => WidgetState.focused.name;
}

class PressedMaterialAttrState extends MaterialAttrState {
  const PressedMaterialAttrState();

  @override
  String get key => WidgetState.pressed.name;
}

class DraggedMaterialAttrState extends MaterialAttrState {
  const DraggedMaterialAttrState();

  @override
  String get key => WidgetState.dragged.name;
}

class SelectedMaterialAttrState extends MaterialAttrState {
  const SelectedMaterialAttrState();

  @override
  String get key => WidgetState.selected.name;
}

class ScrolledUnderMaterialAttrState extends MaterialAttrState {
  const ScrolledUnderMaterialAttrState();

  @override
  String get key => WidgetState.scrolledUnder.name;
}

class DisabledMaterialAttrState extends MaterialAttrState {
  const DisabledMaterialAttrState();

  @override
  String get key => WidgetState.disabled.name;
}

class ErrorMaterialAttrState extends MaterialAttrState {
  const ErrorMaterialAttrState();

  @override
  String get key => WidgetState.error.name;
}

extension MaterialStateSetExt on Set<AttrState> {
  /// Getter for whether this class considers [WidgetState.disabled] to be not active.
  bool get isInteractive => !isDisabled;

  /// Getter for whether this class considers [WidgetState.disabled] to be active.
  bool get isDisabled => contains(MaterialAttrState.disabled);

  /// Getter for whether this class considers [WidgetState.dragged] to be active.
  bool get isDragged => contains(MaterialAttrState.dragged);

  /// Getter for whether this class considers [WidgetState.error] to be active.
  bool get isError => contains(MaterialAttrState.error);

  /// Getter for whether this class considers [WidgetState.focused] to be active.
  bool get isFocused => contains(MaterialAttrState.focused);

  /// Getter for whether this class considers [WidgetState.hovered] to be active.
  bool get isHovered => contains(MaterialAttrState.hovered);

  /// Getter for whether this class considers [WidgetState.pressed] to be active.
  bool get isPressed => contains(MaterialAttrState.pressed);

  /// Getter for whether this class considers [WidgetState.selected] to be active.
  bool get isSelected => contains(MaterialAttrState.selected);

  /// Getter for whether this class considers [WidgetState.selected] to be active.
  bool get isScrolledUnder => contains(MaterialAttrState.scrolledUnder);
}
