import 'dart:math';

import 'package:local_auth/local_auth.dart';
import 'package:bien_aca_quarantine/services/LocalNotificationService.dart';

Future<bool> authenticateFingerprint(int notificationId) async {
  LocalAuthentication localAuth = LocalAuthentication();

  bool authenticated = false;
  try {
    authenticated = await localAuth.authenticateWithBiometrics(
        localizedReason:
            "Utiliza tu huella dactilar para confirmar que eres tú.",
        useErrorDialogs: true,
        stickyAuth: false);
  } on Error catch (e) {
    print(e);
    return false;
  }
  // At the last notification push, reset all notifications with new randomised values
  if (notificationId == 2) {
    int hours;
    int minutes;

    // This is the morning notification - Between 9:00 and 12:00
    hours = 9 + Random().nextInt(11 - 9);
    minutes = 0 + Random().nextInt(30 - 0);
    resetDailyNotificationTime(
        0, hours, minutes, 00, 'doBiometrics-$notificationId');

    // This is the afternoon notification - Between 14:00 and 16:00
    hours = 14 + Random().nextInt(16 - 14);
    minutes = 0 + Random().nextInt(30 - 0);
    resetDailyNotificationTime(
        1, hours, minutes, 00, 'doBiometrics-$notificationId');

    // This is the night notification - Between 18:00 and 20:00
    hours = 18 + Random().nextInt(20 - 18);
    minutes = 0 + Random().nextInt(30 - 0);
    resetDailyNotificationTime(
        2, hours, minutes, 00, 'doBiometrics-$notificationId');
  }
  return authenticated;
}
