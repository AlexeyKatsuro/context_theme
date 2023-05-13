import 'package:flutter/cupertino.dart';

import 'core/attribute.dart';
import 'core/attrs.dart';

class AttributeIconStyle extends AttributeGroup<IconThemeData> {

  const AttributeIconStyle({required super.attributes});

  AttributeIconStyle.named({Attribute<Color>? color, Attribute<double>? fontSize})
      : super(attributes: {
    if (color != null) Attrs.color: color,
    if (fontSize != null) Attrs.iconSize: fontSize,
  });

  Attribute<Color>? get color => get(Attrs.color);

  Attribute<double>? get iconSize => get(Attrs.iconSize);

  @override
  IconThemeData resolve(BuildContext context) {
    return IconThemeData(
      color: color?.resolve(context),
      size: iconSize?.call(context),
    );
  }

  @override
  AttrGroupConstructor<IconThemeData> get constructor => AttributeIconStyle.new;


}