import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/global_functions.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/widgets/app_list.dart';
import 'package:shelf/widgets/fab.dart';

class Desktop extends StatefulWidget {
  const Desktop({super.key});

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => {
        if (menuShown)
          {
            setState(
              () {
                toggleMenu();
              },
            )
          }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: MediaQuery.of(context).orientation == Orientation.portrait
                ? Column(
                    children: [
                      desktopBox1(),
                      searchCard(),
                      desktopBox2(),
                    ],
                  )
                : Row(
                    children: [
                      desktopBox1(),
                      desktopBox2(landscapeOT: true),
                    ],
                  ),
          ),
        ),
        floatingActionButton: fabEnabled ? fab(context) : null,
      ),
    );
  }

  Card searchCard() {
    return Card(
        elevation: ShelfTheme.of(context).uiParameters.cardElevation,
        color: ShelfTheme.of(context)
            .colors
            .primary
            .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                RemixIcon.search,
                size: 30,
              ),
            ),
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: (term) => setState(() {
                  search(term);
                }),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  searchController.clear();
                  search("");
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  RemixIcon.close_circle,
                  size: 30,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  toggleMenu();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: menuShown
                    ? const Icon(
                        RemixIcon.arrow_left_up,
                        size: 30,
                      )
                    : const Icon(
                        RemixIcon.menu_3,
                        size: 30,
                      ),
              ),
            ),
          ],
        ));
  }

  Expanded desktopBox1() {
    return Expanded(
      flex: 2,
      child: desktopBox1Child,
    );
  }

  Expanded desktopBox2({bool landscapeOT = false}) {
    return Expanded(
      flex: 4,
      child: !landscapeOT
          ? desktopBox2Child
          : Column(
              children: [
                searchCard(),
                Expanded(
                  child: desktopBox2Child,
                ),
              ],
            ),
    );
  }
}
