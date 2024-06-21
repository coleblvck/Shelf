
import 'package:flutter/services.dart';


class ShelfChannel {

  static const MethodChannel platformChannel = MethodChannel('shelfChannel');

  static expandNotificationBar() async {
    try {
      await platformChannel.invokeMethod('expandStatusBar');
    } catch (e) {
      null;
    }
  }
}