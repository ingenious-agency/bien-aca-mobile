import 'package:flutter/material.dart';
import 'package:bien_aca_quarantine/services/LocalNotificationService.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName, [LocalNotificationIds notificationId]) {
    if (routeName == 'alertpagebiometrics') {
      try {
        return navigatorKey.currentState.pushNamed(routeName,
            arguments: AlertPageBiometricsArguments(notificationId));
      } catch (e) {
        print(e);
      }
    }
    return navigatorKey.currentState.pushNamed(routeName);
  }
}

class AlertPageBiometricsArguments {
  final LocalNotificationIds notificationId;

  AlertPageBiometricsArguments(this.notificationId);
}
