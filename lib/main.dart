import 'package:flutter/material.dart';
import 'package:shelf/screens/desktop.dart';
import 'package:shelf/state/shelf_state.dart';
import 'package:shelf/state/state_util.dart';
import 'package:shelf/ui/theming.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  shelfState = ShelfState();
  await shelfState.initShelf();
  runApp(
    ShelfTheme(
      colors: currentColorScheme,
      uiParameters: defaultUIParameters,
      child: const Shelf(),
    ),
  );
}

class Shelf extends StatelessWidget {
  const Shelf({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelf',
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ShelfTheme.of(context).colors.onPrimary,
          selectionHandleColor: ShelfTheme.of(context).colors.onPrimary,
          selectionColor: ShelfTheme.of(context).colors.onPrimary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Desktop(),
    );
  }
}
