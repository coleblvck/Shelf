import 'package:flutter/material.dart';
import 'package:shelf/utilities/shelf_utils.dart';

import '../dashboard/dashboard.dart';
import '../flow/flow.dart';
import '../pages/pages.dart';

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
        if (pagesIndex != 1)
          {
            pagesController.animateToPage(
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
                        stream: flowVisibilityStream.stream,
                        builder: (context, snapshot) {
                          final bool isVisible = snapshot.data ?? flowVisible;
                          return isVisible ? const ShelfFlow() : Container();
                        },
                      ),
                      const ShelfPages(),
                      StreamBuilder<bool>(
                        stream: dashboardVisibilityStream.stream,
                        builder: (context, snapshot) {
                          final bool isVisible =
                              snapshot.data ?? dashboardVisible;
                          return isVisible ? const Dashboard() : Container();
                        },
                      ),
                    ],
                  )
                : Row(
                    children: [
                      StreamBuilder<bool>(
                        stream: flowVisibilityStream.stream,
                        builder: (context, snapshot) {
                          final bool isVisible = snapshot.data ?? flowVisible;
                          return isVisible ? const ShelfFlow() : Container();
                        },
                      ),
                      const ShelfPages(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
