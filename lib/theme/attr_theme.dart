// ignore_for_file: unused_element, unused_field

import 'package:attr_theme/theme/attribute.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef SelfConstructor<T extends AttrTheme> = T Function({Key? key, required Widget child});

abstract class AttrTheme extends StatelessWidget {
  const AttrTheme({super.key, required this.child});


  final Widget child;

  Iterable<Attribute> buildAttributes(BuildContext context);


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



class _AttrThemeScope<T extends AttrTheme> extends InheritedTheme {
  const _AttrThemeScope({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw UnimplementedError();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
   return _AttrThemeScope(child: child,);
  }

}

class AttrThemeScopeElement extends InheritedElement {
  AttrThemeScopeElement(super.widget, {required Map<String, Attribute> attributesMap})
      : _attributesMap = attributesMap;

  final Map<String, Attribute> _attributesMap;
}


abstract class AttrThemeGetter {

  Attribute<T> get<T>(String name);
}


//
// class MaterialSurfaceTheme with SurfaceTheme {
//
// }
