import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class ShelfColorScheme {
  const ShelfColorScheme({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.tertiary,
    required this.onTertiary,
    required this.surface,
    required this.onSurface,
    required this.brightness,
    required this.colorSchemeType,
  });
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color tertiary;
  final Color onTertiary;
  final Color surface;
  final Color onSurface;
  final Brightness brightness;
  final ColorSchemeType colorSchemeType;
}

enum ColorSchemeType { shelf, dynamic }

ShelfColorScheme defaultColors = const ShelfColorScheme(
  primary: Color.fromARGB(255, 242, 190, 110),
  onPrimary: Color.fromARGB(255, 0, 0, 0),
  secondary: Color.fromARGB(255, 211, 236, 158),
  onSecondary: Color.fromARGB(255, 0, 0, 0),
  tertiary: Color.fromARGB(255, 255, 221, 175),
  onTertiary: Color.fromARGB(255, 0, 0, 0),
  surface: Color.fromARGB(255, 0, 0, 0),
  onSurface: Color.fromARGB(255, 255, 255, 255),
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
  cardElevation: 2,
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

late ShelfColorScheme currentColorScheme;

getColorScheme() async {
  final corePalette = await DynamicColorPlugin.getCorePalette();
  if (corePalette != null) {
    ColorScheme dynamicColors =
        corePalette.toColorScheme(brightness: Brightness.dark);
    ShelfColorScheme dynamicColorScheme = ShelfColorScheme(
      primary: dynamicColors.primary,
      onPrimary: dynamicColors.onPrimary,
      secondary: dynamicColors.tertiary,
      onSecondary: dynamicColors.onTertiary,
      tertiary: dynamicColors.secondary,
      onTertiary: dynamicColors.onSecondary,
      surface: dynamicColors.surface,
      onSurface: dynamicColors.onSurface,
      brightness: Brightness.dark,
      colorSchemeType: ColorSchemeType.dynamic,
    );
    currentColorScheme = dynamicColorScheme;
  } else {
    currentColorScheme = defaultColors;
  }
}

initColorScheme() async {
  await getColorScheme();
}

refreshColorScheme() async {
  await getColorScheme();
}
