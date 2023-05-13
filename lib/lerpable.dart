import 'package:flutter/material.dart';

abstract class Lerpable<T extends Lerpable<T>> {
  T? lerpTo(T? other, double t);
}

extension LerpableExt<T extends Lerpable<T>> on Lerpable<T> {
  T? lerpFrom(T? other, double t) {
    return lerpTo(other, 1 - t);
  }
}

class ColorThemeData {
  ColorThemeData(
    Color? primary,
    Color? secondary,
    Color? onSecondary,
    Color? onPrimary,
    Color? iconColor,
    Color? textColor,
  );
}
