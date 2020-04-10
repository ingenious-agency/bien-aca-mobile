import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../service_locator.dart';
import 'NavigationService.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidInitializationSettings initializationSettingsAndroid;
IOSInitializationSettings initializationSettingsIOS;
InitializationSettings initializationSettings;

void initializeLocalNotifications(onDidReceiveLocalNotification,
    {onSelectNotification = onSelectNotification}) async {
  initializationSettingsAndroid = AndroidInitializationSettings('icon');
  initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );
  initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}

Future<void> generateDailyNotification(int id, hours, minutes, seconds, payload) async {
  print('<======= daily notification triggered =======>');
  Time dayTime = Time(hours, minutes, seconds);

  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('repeat_daily_at_time', 'Repeat daily at time',
          'Repeats a daily notification several times on a day.',
          priority: Priority.High,
          importance: Importance.Max,
          ticker: 'repeatDailyAtTime');
  IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

  NotificationDetails notificationDetails =
      NotificationDetails(androidNotificationDetails, iosNotificationDetails);

  await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      "Prueba de vida",
      "Ingrese a la app para probar que está con su celular.",
      dayTime,
      notificationDetails,
      payload: payload
  );
}

void generateInstantNotification(String title, String body, String payload) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('instant_alert', 'Instant alert',
          'Instant alert notification to notify the user as soon as possible');
  IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails();
  NotificationDetails platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  try {
    await flutterLocalNotificationsPlugin.show(
        1, title, body, platformChannelSpecifics, payload: payload );
  } catch (e) {
    print(e);
  }
}

Future<void> onSelectNotification(String payload) {
  if (payload != null) {
    print('notification payload: ' + payload);
  }
  if (payload == 'doBiometrics') {
    locator<NavigationService>().navigateTo('alertpagebiometrics');
  }
  return null;
}

//      id,
//      "Prueba de vida",
//      "Ingrese a la app para probar que está con su celular.",
//      Time(hours, minutes, seconds),
//      notificationDetails,
//      payload: "gotoBiometrics");
