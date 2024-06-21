import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf/screens/desktop.dart';
import 'package:shelf/state/shelf_state.dart';
import 'package:shelf/state/state_util.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/utilities/user_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  shelfState = ShelfState();
  userPrefs = await SharedPreferences.getInstance();
  await shelfState.initShelf();
  runApp(const Shelf());
}

class Shelf extends StatelessWidget {
  const Shelf({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return StreamBuilder<ShelfColorScheme>(
        stream: colorSchemeStream.stream,
        builder: (context, snapshot) {
          return ShelfTheme(
            colors: snapshot.data ?? currentColorScheme!,
            uiParameters: defaultUIParameters,
            child: MaterialApp(
              title: 'Shelf',
              theme: ThemeData(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: currentColorScheme!.onPrimary,
                  selectionHandleColor: currentColorScheme!.onPrimary,
                  selectionColor: currentColorScheme!.onPrimary,
                ),
              ),
              debugShowCheckedModeBanner: false,
              home: const Desktop(),
            ),
          );
        }
      );

  }
}
