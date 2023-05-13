
import 'package:attr_theme/attributes/core/attribute.dart';
import 'package:flutter/widgets.dart';

import 'core/attrs.dart';

class AttributeTextStyle extends AttributeGroup<TextStyle> {

  const AttributeTextStyle({required super.attributes});

  AttributeTextStyle.named({Attribute<Color>? color, Attribute<double>? fontSize})
      : super(attributes: {
    if (color != null) Attrs.color: color,
    if (fontSize != null) Attrs.fontSize: fontSize,
  });

  Attribute<Color>? get color => get(Attrs.color);

  Attribute<double>? get fontSize => get(Attrs.fontSize);

  @override
  TextStyle resolve(BuildContext context) {
    return TextStyle(
      color: color?.resolve(context),
      fontSize: fontSize?.call(context),
    );
  }

  @override
  AttrGroupConstructor<TextStyle> get constructor => AttributeTextStyle.new;


}