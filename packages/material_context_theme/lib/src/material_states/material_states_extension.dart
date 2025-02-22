import 'package:flutter/material.dart';

/// Syntactic sugar for Set<WidgetState> to simplify states condition like
///
/// Before
/// ```dart
///  if (states.contains(WidgetState.focused) || states.contains(WidgetState.pressed)) {
///    ...
///  }
/// ```
/// After
/// ```dart
///  if (states.isFocused || states.isPressed) {
///    ...
///  }
/// ```
extension MaterialStateSetExt on Set<WidgetState> {
  /// Getter for whether this class considers [WidgetState.disabled] to be not active.
  bool get isInteractive => !isDisabled;

  /// Getter for whether this class considers [WidgetState.disabled] to be active.
  bool get isDisabled => contains(WidgetState.disabled);

  /// Getter for whether this class considers [WidgetState.dragged] to be active.
  bool get isDragged => contains(WidgetState.dragged);

  /// Getter for whether this class considers [WidgetState.error] to be active.
  bool get isError => contains(WidgetState.error);

  /// Getter for whether this class considers [WidgetState.focused] to be active.
  bool get isFocused => contains(WidgetState.focused);

  /// Getter for whether this class considers [WidgetState.hovered] to be active.
  bool get isHovered => contains(WidgetState.hovered);

  /// Getter for whether this class considers [WidgetState.pressed] to be active.
  bool get isPressed => contains(WidgetState.pressed);

  /// Getter for whether this class considers [WidgetState.selected] to be active.
  bool get isSelected => contains(WidgetState.selected);
}
