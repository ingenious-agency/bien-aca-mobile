import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidInitializationSettings initializationSettingsAndroid;
IOSInitializationSettings initializationSettingsIOS;
InitializationSettings initializationSettings;

void initializeLocalNotifications(onDidReceiveLocalNotification, onSelectNotification) async {
  print(onDidReceiveLocalNotification);
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

Future<void> generateDailyNotification(int id, hours, minutes, seconds) async {
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
      id,
      "Prueba de vida",
      "Ingrese a la app para probar que está con su celular.",
      Time(hours, minutes, seconds),
      notificationDetails,
      payload: "gotoBiometrics");
}