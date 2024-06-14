import 'package:flutter/material.dart';

class ShelfColorScheme {
  const ShelfColorScheme({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.surface,
    required this.onSurface,
    required this.brightness,
    required this.colorSchemeType,
  });
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color surface;
  final Color onSurface;
  final Brightness brightness;
  final ColorSchemeType colorSchemeType;
}

enum ColorSchemeType { shelf, dynamic }

ShelfColorScheme defaultColors = ShelfColorScheme(
  primary: Colors.orange,
  onPrimary: Colors.black,
  secondary: Colors.purple.withBlue(10),
  onSecondary: Colors.black,
  surface: Colors.black,
  onSurface: Colors.white,
  brightness: Brightness.dark,
  colorSchemeType: ColorSchemeType.shelf,
);

class UIParameters {
  const UIParameters({
    required this.cardElevation,
    required this.cardAlpha,
  });
  final double cardElevation;
  final int cardAlpha;
}

UIParameters defaultUIParameters = const UIParameters(
  cardElevation: 5,
  cardAlpha: 450,
);

class ShelfTheme extends InheritedWidget {
  const ShelfTheme({
    super.key,
    required super.child,
    required this.colors,
    required this.uiParameters,
  });

  final ShelfColorScheme colors;
  final UIParameters uiParameters;

  static ShelfTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShelfTheme>();
  }

  static ShelfTheme of(BuildContext context) {
    final ShelfTheme? result = maybeOf(context);
    assert(result != null, 'No ShelfTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ShelfTheme oldWidget) {
    return oldWidget.colors != colors;
  }
}
