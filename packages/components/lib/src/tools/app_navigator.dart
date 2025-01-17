import 'package:components/components.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static Future<dynamic> navigateTo({
    required NavigationType type,
    required Widget widget,
  }) {
    switch (type) {
      case NavigationType.navigateTo:
        return Navigator.push(
          NavigationService.navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => widget,
          ),
        ).then((value) => value);
      case NavigationType.navigateAndFinish:
        return Navigator.pushAndRemoveUntil(
          NavigationService.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => widget),
          (route) => false,
        ).then((value) => value);
    }
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
