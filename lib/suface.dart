
import 'package:attr_theme/lerpable.dart';
import 'package:attr_theme/mergable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef ContextBuilder<T> = T Function(BuildContext context);

T lerpBinary<T>(T a, T b, double t) {
  return t < 0.5 ? a : b;
}
T lerpBinaryNotNull<T extends Object>(T? a, T? b, double t) {
  if (a == null && b == null) {
    throw ArgumentError('At least one value, a or b must not be null');
  }
  if (a == null) return b as T;
  if (b == null) return a;
  return t < 0.5 ? a : b;
}

@immutable
class SurfaceStyle
    with Diagnosticable
    implements Lerpable<SurfaceStyle>, Mergeable<SurfaceStyle> {
  const SurfaceStyle({
    bool? inherit,
    this.textStyle,
    this.iconStyle,
    this.textAlign,
    this.background,
    this.foreground,
    this.shape,
  }) : inherit = inherit ?? true;

  @override
  final bool inherit;

  final TextStyle? textStyle;
  final IconThemeData? iconStyle;
  final TextAlign? textAlign;
  final Color? background;
  final Color? foreground;
  final OutlinedBorder? shape;


  @override
  int get hashCode {
    return Object.hash(
      inherit,
      textStyle,
      iconStyle,
      textAlign,
      background,
      foreground,
      shape,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SurfaceStyle &&
        other.inherit == inherit &&
        other.textStyle == textStyle &&
        other.iconStyle == iconStyle &&
        other.textAlign == textAlign &&
        other.background == background &&
        other.foreground == foreground &&
        other.shape == shape;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('inherit', value: inherit, showName: true));
    properties.add(DiagnosticsProperty<TextStyle>('textStyle', textStyle, defaultValue: null));
    properties.add(DiagnosticsProperty<IconThemeData>('iconStyle', iconStyle, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('background', background, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('foreground', foreground, defaultValue: null));
    properties.add(DiagnosticsProperty<OutlinedBorder>('shape', shape, defaultValue: null));
    properties.add(EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: null));
  }

  @override
  SurfaceStyle? lerpTo(SurfaceStyle? other, double t) {
    if (t == 0) return this;
    if (t == 1) return other;
    return SurfaceStyle(
      inherit: lerpBinaryNotNull(inherit, other?.inherit, t),
      textStyle: TextStyle.lerp(textStyle, other?.textStyle, t),
      iconStyle: IconThemeData.lerp(iconStyle, other?.iconStyle, t),
      textAlign: lerpBinary(textAlign, other?.textAlign, t),
      background: Color.lerp(background, other?.background, t),
      foreground: Color.lerp(foreground, other?.foreground, t),
      shape: OutlinedBorder.lerp(shape, other?.shape, t),
    );
  }

  @override
  SurfaceStyle merge(SurfaceStyle? other) {
    return copyWith(
      textStyle: other?.textStyle?.mergeTo(textStyle),
      iconStyle: other?.iconStyle?.mergeTo(iconStyle),
      textAlign: other?.textAlign,
      background: other?.background,
      foreground: other?.foreground,
      shape: other?.shape,
    );
  }

  SurfaceStyle copyWith({
    TextStyle? textStyle,
    IconThemeData? iconStyle,
    TextAlign? textAlign,
    Color? background,
    Color? foreground,
    OutlinedBorder? shape,
  }) {
    return SurfaceStyle(
      textStyle: textStyle ?? this.textStyle,
      iconStyle: iconStyle ?? this.iconStyle,
      textAlign: textAlign ?? this.textAlign,
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      shape: shape ?? this.shape,
    );
  }
}

class SurfaceTheme extends InheritedTheme {
  const SurfaceTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static ContextBuilder<SurfaceStyle> defaultTheme = (context) {
    return const SurfaceStyle();
  };

  final SurfaceStyle data;

  static SurfaceStyle of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<SurfaceTheme>()
        ?.data;
    return theme ?? defaultTheme(context);
  }

  static Widget merge({required Widget child, required SurfaceStyle? data}) {
    return Builder(
      builder: (BuildContext context) {
        return SurfaceTheme(
          data: SurfaceTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  @override
  bool updateShouldNotify(SurfaceTheme oldWidget) => data != oldWidget.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return SurfaceTheme(data: data, child: child);
  }
}
