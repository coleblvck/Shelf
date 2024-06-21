import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchState {
  String _launchIntent = "";
  final TextEditingController controller = TextEditingController();
  final StreamController stream = StreamController.broadcast();
  search() {
    stream.add(controller.text);
    updateLaunchIntent(controller.text);
  }

  clear() {
    controller.text = "";
    stream.add("");
  }

  updateLaunchIntent(String text) {
    if (!text.startsWith("https://") && !text.startsWith("http://")) {
      _launchIntent = "https://www.google.com/search?q=$text";
    } else {
      _launchIntent = text;
    }
  }

  launchBrowserSearch() async {
    final uri = Uri.parse(_launchIntent);
    try {
      await launchUrl(uri);
    } catch (e) {
      null;
    }
  }
}
