import 'package:flutter/material.dart';

/// Syntactic sugar for Set<MaterialState> to simplify states condition like
///
/// Before
/// ```dart
///  if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
///    ...
///  }
/// ```
/// After
/// ```dart
///  if (states.isFocused || states.isPressed) {
///    ...
///  }
/// ```
extension MaterialStateSetExt on Set<MaterialState> {
  /// Getter for whether this class considers [MaterialState.disabled] to be not active.
  bool get isInteractive => !isDisabled;

  /// Getter for whether this class considers [MaterialState.disabled] to be active.
  bool get isDisabled => contains(MaterialState.disabled);

  /// Getter for whether this class considers [MaterialState.dragged] to be active.
  bool get isDragged => contains(MaterialState.dragged);

  /// Getter for whether this class considers [MaterialState.error] to be active.
  bool get isError => contains(MaterialState.error);

  /// Getter for whether this class considers [MaterialState.focused] to be active.
  bool get isFocused => contains(MaterialState.focused);

  /// Getter for whether this class considers [MaterialState.hovered] to be active.
  bool get isHovered => contains(MaterialState.hovered);

  /// Getter for whether this class considers [MaterialState.pressed] to be active.
  bool get isPressed => contains(MaterialState.pressed);

  /// Getter for whether this class considers [MaterialState.selected] to be active.
  bool get isSelected => contains(MaterialState.selected);
}
