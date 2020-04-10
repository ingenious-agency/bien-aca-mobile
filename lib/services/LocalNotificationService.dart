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
  print('<======= daily notification triggered =======>');
  var dayTime = Time(hours, minutes, seconds);

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
      id, "Prueba de vida", "Ingrese a la app para probar que está con su celular.", dayTime, notificationDetails);
}

void generateInstantNotification(String title, String body) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'instant_alert',
      'Instant alert',
      'Instant alert notification to notify the user as soon as possible');
  IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails();
  NotificationDetails platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  try {
    await flutterLocalNotificationsPlugin.show(
        1, title, body, platformChannelSpecifics);
  } catch (e) {
    print(e);
  }
}




Future<void> onSelectNotification(String payload) {
  if (payload != null) {
    print('notification payload: ' + payload);
  }
  // Here you can set navigations when notification is sent
  return null;
}

//      id,
//      "Prueba de vida",
//      "Ingrese a la app para probar que está con su celular.",
//      Time(hours, minutes, seconds),
//      notificationDetails,
//      payload: "gotoBiometrics");
