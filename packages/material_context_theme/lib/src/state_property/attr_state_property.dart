import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'attr_state.dart';

typedef AttrPropertyResolver<T> = T Function(Set<AttrState> states);
typedef LerpFunction<T> = T? Function(T?, T?, double);

abstract class AttrStateProperty<T> {
  const AttrStateProperty();

  const factory AttrStateProperty.resolveWith(AttrPropertyResolver<T> callback) =
      AttrStatePropertyWith<T>;

  const factory AttrStateProperty.all(T value) = AttrStatePropertyAll<T>;

  T resolve(Set<AttrState> states);

  static T resolveAs<T>(T value, Set<AttrState> states) {
    if (value is AttrStateProperty<T>) {
      return value.resolve(states);
    }
    return value;
  }

  static AttrStateProperty<T?>? lerp<T>(
    AttrStateProperty<T>? a,
    AttrStateProperty<T>? b,
    double t,
    LerpFunction<T> lerpFunction,
  ) {
    // Avoid creating a _LerpProperties object for a common case.
    if (a == null && b == null) {
      return null;
    }
    return AtterLerpProperties<T>(a, b, t, lerpFunction);
  }
}

class AttrStatePropertyAll<T> extends AttrStateProperty<T> with AttrStatePropertyAllMixin<T> {
  const AttrStatePropertyAll(this.value);

  @override
  final T value;
}

mixin AttrStatePropertyAllMixin<T> on AttrStateProperty<T> {
  T get value;

  @override
  T resolve(Set<AttrState> states) => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttrStatePropertyAll && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class AttrStatePropertyWith<T> extends AttrStateProperty<T> with AttrStatePropertyWithMixin {
  const AttrStatePropertyWith(this.resolver);

  @override
  final AttrPropertyResolver<T> resolver;
}

mixin AttrStatePropertyWithMixin<T> on AttrStateProperty<T> {
  @protected
  AttrPropertyResolver<T> get resolver;

  @override
  T resolve(Set<AttrState> states) => resolver(states);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttrStatePropertyWithMixin &&
          runtimeType == other.runtimeType &&
          resolver == other.resolver;

  @override
  int get hashCode => resolver.hashCode;
}

class AtterLerpProperties<T> implements AttrStateProperty<T?> {
  const AtterLerpProperties(this.a, this.b, this.t, this.lerpFunction);

  final AttrStateProperty<T>? a;
  final AttrStateProperty<T>? b;
  final double t;
  final LerpFunction<T> lerpFunction;

  @override
  T? resolve(Set<AttrState> states) {
    final resolvedA = a?.resolve(states);
    final resolvedB = b?.resolve(states);
    return lerpFunction(resolvedA, resolvedB, t);
  }
}

abstract class AttrStateTextStyle extends TextStyle implements AttrStateProperty<TextStyle> {
  const AttrStateTextStyle();

  const factory AttrStateTextStyle.resolveWith(AttrPropertyResolver<TextStyle> callback) =
      TextStyleStatePropertyWith;

  const factory AttrStateTextStyle.all(TextStyle value) = TextStyleStatePropertyAll;

  @override
  TextStyle resolve(Set<AttrState> states);
}

class TextStyleStatePropertyAll extends AttrStateTextStyle
    with AttrStatePropertyAllMixin<TextStyle> {
  const TextStyleStatePropertyAll(this.value);

  @override
  final TextStyle value;
}

class TextStyleStatePropertyWith extends AttrStateTextStyle
    with AttrStatePropertyWithMixin<TextStyle> {
  const TextStyleStatePropertyWith(this.resolver);

  @override
  final AttrPropertyResolver<TextStyle> resolver;
}
