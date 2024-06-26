import 'package:flutter/material.dart';
import 'package:parallax_rain/parallax_rain.dart';
import 'package:shelf/state/flow_state.dart';
import 'package:shelf/state/pages_state.dart';
import 'package:shelf/state/parallax_state.dart';
import 'package:shelf/ui/theming.dart';

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
      onPopInvoked: (didPop) {
        FocusManager.instance.primaryFocus?.unfocus();
        final PagesState pages = shelfState.pages;
        if (pages.currentIndex % pages.pageCount != 1) {
          pages.controller.animateToPage(
            pages.currentIndex <= (pages.itemCount - 1) / 2
                ? pages.currentIndex + 1
                : pages.currentIndex - 1,
            curve: Curves.decelerate,
            duration: const Duration(milliseconds: 200),
          );
        } else {
          final FlowState flow = shelfState.flow;
          if (flow.currentIndex % flow.cardCount != 0) {
            shelfState.flow.controller.animateToPage(
              flow.currentIndex <= (flow.itemCount - 1) / 2
                  ? flow.currentIndex + 1
                  : flow.currentIndex - 1,
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 200),
            );
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: StreamBuilder<ParallaxStatus>(
            stream: shelfState.parallax.statusStream.stream,
            builder: (context, snapshot) {
              ParallaxStatus status =
                  snapshot.data ?? shelfState.parallax.status;
              return status != ParallaxStatus.off
                  ? ParallaxRain(
                      dropColors: [
                        ShelfTheme.of(context).colors.primary,
                        ShelfTheme.of(context).colors.secondary,
                      ],
                      dropFallSpeed: 2,
                      numberOfDrops: 100,
                      dropWidth: 0.5,
                      dropHeight: 8,
                      trail: true,
                      rainIsInBackground: false,
                      trailStartFraction: 0.2,
                      numberOfLayers: 3,
                      distanceBetweenLayers: 2,
                      child: const DesktopContent(),
                    )
                  : const DesktopContent();
            }),
      ),
    );
  }
}

class DesktopContent extends StatelessWidget {
  const DesktopContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
                children: [
                  StreamBuilder<bool>(
                    stream: shelfState.flow.visibilityStream.stream,
                    builder: (context, snapshot) {
                      final bool isVisible =
                          snapshot.data ?? shelfState.flow.visible;
                      return isVisible ? ShelfFlow() : Container();
                    },
                  ),
                  const ShelfPages(),
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
                  const ShelfPages(),
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
    );
  }
}
