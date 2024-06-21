import 'package:flutter/material.dart';

import '../state/state_util.dart';
import '../ui/dashboard/dashboard.dart';
import '../ui/flow/flow.dart';
import '../ui/pages/pages.dart';

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
        if (shelfState.pages.index != 1)
          {
            shelfState.pages.controller.animateToPage(
              1,
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 300),
            ),
          },
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: MediaQuery.of(context).orientation == Orientation.portrait
                ? Column(
                    children: [
                      StreamBuilder<bool>(
                        stream: shelfState.flow.visibilityStream.stream,
                        builder: (context, snapshot) {
                          final bool isVisible = snapshot.data ?? shelfState.flow.visible;
                          return isVisible ? const ShelfFlow() : Container();
                        },
                      ),
                      ShelfPages(),
                      StreamBuilder<bool>(
                        stream: shelfState.dashboard.visibilityStream.stream,
                        builder: (context, snapshot) {
                          final bool isVisible =
                              snapshot.data ?? shelfState.dashboard.visible;
                          return isVisible ? const Dashboard() : Container();
                        },
                      ),
                    ],
                  )
                : Column(
                    children: [
                      ShelfPages(),
                      StreamBuilder<bool>(
                        stream: shelfState.dashboard.visibilityStream.stream,
                        builder: (context, snapshot) {
                          final bool isVisible =
                              snapshot.data ?? shelfState.dashboard.visible;
                          return isVisible ? const Dashboard() : Container();
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
