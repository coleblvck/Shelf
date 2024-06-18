import 'package:flutter/material.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/ui/theming.dart';

class PeekBox extends StatelessWidget {
  const PeekBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection:
          MediaQuery.of(context).orientation == Orientation.portrait
              ? Axis.horizontal
              : Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            elevation: ShelfTheme.of(context).uiParameters.cardElevation,
            color: ShelfTheme.of(context)
                .colors
                .secondary
                .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
            child: Center(
              child: peekCard1(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            elevation: ShelfTheme.of(context).uiParameters.cardElevation,
            color: ShelfTheme.of(context)
                .colors
                .surface
                .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
            child: Container(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            elevation: ShelfTheme.of(context).uiParameters.cardElevation,
            color: ShelfTheme.of(context)
                .colors
                .primary
                .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
            child: Container(),
          ),
        ),
      ],
    );
  }
}

//Move this
peekCard1() => const Column(
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: GreetingsWidget(),
          ),
        ),
        /*Expanded(
      child: Center(
        child: FavouritesWidget(),
      ),
    ),*/
      ],
    );

class FavouritesWidget extends StatelessWidget {
  const FavouritesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: allAppsListStream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.memory(snapshot.data![5].icon!),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                  Image.memory(snapshot.data![6].icon!),
                ],
              ),
            );
          }
          if (allAppsList.isNotEmpty) {
            return Row(
              children: [
                Image.memory(snapshot.data![5].icon!),
                Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                Image.memory(snapshot.data![6].icon!),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      greetingText,
      style: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
