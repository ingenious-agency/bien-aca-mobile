import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidInitializationSettings initializationSettingsAndroid;
IOSInitializationSettings initializationSettingsIOS;
InitializationSettings initializationSettings;

void initializeLocalNotifications(onDidReceiveLocalNotification) async {
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

Future<void> generateDailyNotification(Time dayTime) async {
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('repeat_daily_at_time',
          'Repeat daily at time', 'Repeats a daily notification several times on a day.',
          priority: Priority.High,
          importance: Importance.Max,
          ticker: 'repeatDailyAtTime');
  IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

  NotificationDetails notificationDetails =
      NotificationDetails(androidNotificationDetails, iosNotificationDetails);

  await flutterLocalNotificationsPlugin.showDailyAtTime(
      0, "Prueba de vida", "Ingrese a la app para probar que está con su celular.", dayTime, notificationDetails);
}

Future<void> onSelectNotification(String payload) {
  if (payload != null) {
    debugPrint('notification payload: ' + payload);
  }
  // Here you can set navigations when notification is sent
  return null;
}
