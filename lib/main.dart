import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shelf/global_functions.dart';
import 'package:shelf/screens/desktop.dart';
import 'package:shelf/ui/theming.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  //Move to desktop build?
  initAppList();
  runApp(const Shelf());
}

class Shelf extends StatelessWidget {
  const Shelf({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ShelfColorScheme? dynamicScheme;
      darkDynamic != null
          ? dynamicScheme = ShelfColorScheme(
              primary: darkDynamic.primary,
              onPrimary: darkDynamic.onPrimary,
              secondary: darkDynamic.tertiary,
              onSecondary: darkDynamic.onTertiary,
              surface: darkDynamic.surface,
              onSurface: darkDynamic.onSurface,
              brightness: Brightness.dark,
              colorSchemeType: ColorSchemeType.dynamic,
            )
          : null;
      return ShelfTheme(
        colors: dynamicScheme ?? defaultColors,
        uiParameters: defaultUIParameters,
        child: MaterialApp(
          title: 'Shelf',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const Desktop(),
        ),
      );
    });
  }
}
