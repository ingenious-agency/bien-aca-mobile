import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName, [dynamic notificationId]) {
    if (routeName == 'alertpagebiometrics') {
      try {
        return navigatorKey.currentState.pushNamed(routeName,
            arguments: AlertPageBiometricsArguments(int.parse(notificationId)));
      } catch (e) {
        print(e);
      }
    }
    return navigatorKey.currentState.pushNamed(routeName);
  }
}

class AlertPageBiometricsArguments {
  final int notificationId;

  AlertPageBiometricsArguments(this.notificationId);
}
