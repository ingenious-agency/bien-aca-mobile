import 'dart:math';

import 'package:local_auth/local_auth.dart';
import 'package:bien_aca_quarantine/services/LocalNotificationService.dart';

Future<bool> authenticateFingerprint(
    LocalNotificationIds notificationId) async {
  LocalAuthentication localAuth = LocalAuthentication();

  reRandomDailyNotifications(notificationId);

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

  return authenticated;
}

/// Makes a re-random of sthe next daily notification using the following logic:
///
/// If [id] == `morningDaily` -> Re-random `LocalNotificationIds.middayDaily`
///
/// If [id] == `middayDaily` -> Re-random `LocalNotificationIds.afternoonDaily`
///
/// If [id] == `afternoonDaily` -> Re-random `LocalNotificationIds.morningDaily`
void reRandomDailyNotifications(notificationId) {
  int hours;
  int minutes = 0 + Random().nextInt(30 - 0);
  switch (notificationId) {
    case LocalNotificationIds.morningDaily:
      print("next midday");
      // Next notification to reset: midday notification - Between 14:00 and 16:00
      hours = 14 + Random().nextInt(16 - 14);
      generateDailyNotification(
        LocalNotificationIds.middayDaily,
        hours,
        minutes,
        00,
      );
      break;
    case LocalNotificationIds.middayDaily:
      print("next afternoon");
      // Next notification to reset: afternoon notification - Between 18:00 and 20:00
      hours = 18 + Random().nextInt(20 - 18);
      generateDailyNotification(
        LocalNotificationIds.afternoonDaily,
        hours,
        minutes,
        00,
      );
      break;
    case LocalNotificationIds.afternoonDaily:
      print("next morning");
      // Next notification to reset: morning notification - Between 9:00 and 12:00
      hours = 9 + Random().nextInt(12 - 9);
      generateDailyNotification(
        LocalNotificationIds.morningDaily,
        hours,
        minutes,
        00,
      );
      break;
    default:
  }
}
