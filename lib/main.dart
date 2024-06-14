import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shelf/screens/desktop.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/utilities/shelf_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initColorScheme();
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
      return StreamBuilder<ShelfColorScheme>(
        stream: colorSchemeStream.stream,
        builder: (context, snapshot) {
          return ShelfTheme(
            colors: snapshot.data ?? currentColorScheme!,
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
        }
      );

  }
}
