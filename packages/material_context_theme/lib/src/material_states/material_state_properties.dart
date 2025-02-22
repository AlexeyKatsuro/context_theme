import 'package:flutter/material.dart';

class MaterialStateColor<C extends Color?> extends Color implements WidgetStateProperty<C> {
  MaterialStateColor.resolveWith(
    WidgetPropertyResolver<C> callback, {
    Set<WidgetState> defaultStates = const {},
  })  : _resolve = callback,
        super(callback(defaultStates)?.toARGB32() ?? 0x00000000);

  final WidgetPropertyResolver<C> _resolve;

  @override
  C resolve(Set<WidgetState> states) => _resolve(states);
}

extension MaterialStatePropertyTransform<T> on T {
  WidgetStateProperty<T>? toMaterialStateProperty() {
    final value = this;
    if (value == null) return null;
    if (value is WidgetStateProperty<T>) return value;
    return WidgetStatePropertyAll<T>(value);
  }
}
