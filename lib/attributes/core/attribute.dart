import 'package:flutter/widgets.dart';

typedef AttrGroupConstructor<S> = AttributeGroup<S> Function(
    {required Map<String, Attribute> attributes});

abstract class Attribute<T> {
  const Attribute();

  T call(BuildContext context) => resolve(context);

  T resolve(BuildContext context);

// T? lerpTo(T? other, double t);
//
// T? lerpFrom(T? other, double t) => lerpTo(other, 1 - t);

}

abstract class AttributeGroup<Style> extends Attribute<Style> {
  const AttributeGroup({required this.attributes});

  AttrGroupConstructor<Style> get constructor;

  final Map<String, Attribute> attributes;

  Attribute<T> get<T>(String name) => attributes[name] as Attribute<T>;

  AttributeGroup<Style> mergeTo(AttributeGroup<Style>? child) {
    if (child == null) return this;
    return constructor(attributes: {
      ...attributes,
      ...child.attributes,
    });
  }

  AttributeGroup<Style> mergeFrom(AttributeGroup<Style>? parent) {
    if (parent == null) return this;
    return parent.mergeTo(this);
  }
}
