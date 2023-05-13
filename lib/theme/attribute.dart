import 'package:flutter/material.dart';


abstract class Attribute<T> {
  const Attribute();

  T call(BuildContext context) => resolve(context);

  T resolve(BuildContext context);

// T? lerpTo(T? other, double t);
//
// T? lerpFrom(T? other, double t) => lerpTo(other, 1 - t);

}





class AttributeValueColor extends Attribute<Color> {
  const AttributeValueColor({required this.name, required this.value});

  final String name;

  final Color value;

  @override
  Color resolve(BuildContext context) => value;

  Color? lerpTo(Color? other, double t) {
    if (t == 0) return value;
    if (t == 1) return other;
    return Color.lerp(value, other, t);
  }
}

class AttributeRef<T> extends Attribute<T> {
  const AttributeRef({required this.name, required this.ref});

  final String name;

  final Attribute<T> ref;

  @override
  T resolve(BuildContext context) {
    return ref(context);
  }
}
