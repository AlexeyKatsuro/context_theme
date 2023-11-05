import 'package:flutter/material.dart';


class MaterialStateColor<C extends Color?> extends Color implements MaterialStateProperty<C> {
  MaterialStateColor.resolveWith(MaterialPropertyResolver<C> callback,
      {Set<MaterialState> defaultStates = const {}})
      : _resolve = callback,
        super(callback(defaultStates)?.value ?? 0x00000000);

  final MaterialPropertyResolver<C> _resolve;

  @override
  C resolve(Set<MaterialState> states) => _resolve(states);
}

extension MaterialStatePropertyTransform<T> on T {
  MaterialStateProperty<T>? toMaterialStateProperty() {
    final value = this;
    if (value == null) return null;
    if (value is MaterialStateProperty<T>) return value;
    return MaterialStatePropertyAll<T>(value);
  }
}



