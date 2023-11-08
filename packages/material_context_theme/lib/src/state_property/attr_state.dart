import 'package:flutter/foundation.dart';

@immutable
abstract class AttrState {
  const AttrState();

  String get key;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AttrState && key == other.key;

  @override
  int get hashCode => key.hashCode;
}

class AttrStateFactory {}
