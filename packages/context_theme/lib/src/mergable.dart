import 'package:flutter/widgets.dart';

import 'state_property/attr_state.dart';
import 'state_property/attr_state_property.dart';




typedef MergeFunction<T> = T Function(T, T);

abstract class Mergeable<T> {
  bool get inherit;

  T merge(T? other);
}

extension MergeToExt<T extends Mergeable<T>> on T {
  T mergeTo(T? parent) {
    if (parent == null) return this;
    return parent.merge(this);
  }
}


extension MergeReplacePropertyExt<T> on AttrStateProperty<T> {
  AttrStateProperty<T> merge(AttrStateProperty<T?>? other, [MergeFunction<T?>? merge]) {
    if (other == null || other == this) return this;
    return MergedAttrProperty<T?>(this, other, merge) as AttrStateProperty<T>;
  }

  AttrStateProperty<T?> mergeTo(AttrStateProperty<T?>? other, [MergeFunction<T?>? merge]) {
    if (other == null) return this;
    return other.merge(this, merge);
  }
}

/// A class that allows merging between two nullable AttrStateProperty.
class MergedAttrProperty<T> implements AttrStateProperty<T?> {
  const MergedAttrProperty(this.a, this.b, [this.mergeFunction]);

  final AttrStateProperty<T>? a;
  final AttrStateProperty<T>? b;
  final MergeFunction<T?>? mergeFunction;

  @override
  T? resolve(Set<AttrState> states) {
    final T? resolvedA = a?.resolve(states);
    final T? resolvedB = b?.resolve(states);
    if (mergeFunction == null) {
      return resolvedB ?? resolvedA;
    }
    return mergeFunction!(resolvedA, resolvedB);
  }
}

extension MergeIconThemeDataExt on IconThemeData {
  IconThemeData mergeTo(IconThemeData? other) {
    if (other == null) return this;
    return other.merge(this);
  }
}

IconThemeData? mergeIconThemeData(IconThemeData? a, IconThemeData? b) => a?.merge(b) ?? b;

TextStyle? mergeTextStyle(TextStyle? a, TextStyle? b) => a?.merge(b) ?? b;

extension MergeTextStyleExt on TextStyle {
  TextStyle mergeTo(TextStyle? other) {
    if (other == null) return this;
    return other.merge(this);
  }
}