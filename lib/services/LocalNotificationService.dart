import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../service_locator.dart';
import 'NavigationService.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidInitializationSettings initializationSettingsAndroid;
IOSInitializationSettings initializationSettingsIOS;
InitializationSettings initializationSettings;

/// Notification IDs stored in an enum - access the value using `.index` accessor within enum elements
enum LocalNotificationIds {
  morningDaily,
  middayDaily,
  afternoonDaily,
  outOfZoneInstant,
  lostHeartbeatScheduled,
  lostConnectivityInstant,
  lostGpsInstant,
  testSchedule
}

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

Future<void> generateDailyNotification(
    LocalNotificationIds localNotificationId, hours, minutes, seconds) async {
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
      localNotificationId.index,
      "Prueba de vida",
      "Ingrese a la app para probar que está con su celular.",
      dayTime,
      notificationDetails,
      payload: "doBiometrics-$localNotificationId");
}

void generateInstantNotification(LocalNotificationIds localNotificationId,
    String title, String body, String payload) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('instant_alert', 'Instant alert',
          'Instant alert notification to notify the user as soon as possible');
  IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails();

  NotificationDetails platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  try {
    await flutterLocalNotificationsPlugin.show(
        localNotificationId.index, title, body, platformChannelSpecifics,
        payload: payload);
  } catch (e) {
    print(e);
  }
}

Future<void> generateScheduledNotification(
    LocalNotificationIds localNotificationId,
    {hours,
    minutes,
    seconds,
    payload,
    title,
    body}) async {
  print('<======= scheduled notification triggered =======>');

  DateTime scheduledNotificationDateTime = DateTime.now()
      .add(Duration(hours: hours, minutes: minutes, seconds: seconds));

  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
          'scheduled_notification',
          'Schedule notification',
          'Schedules a notification for a time in the future.',
          priority: Priority.High,
          importance: Importance.Max,
          ticker: 'scheduledNotification');
  IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

  NotificationDetails notificationDetails =
      NotificationDetails(androidNotificationDetails, iosNotificationDetails);

  await flutterLocalNotificationsPlugin.schedule(localNotificationId.index,
      title, body, scheduledNotificationDateTime, notificationDetails,
      payload: payload);
}

Future<void> onSelectNotification(String payload) {
  if (payload.startsWith("doBiometrics")) {
    locator<NavigationService>().navigateTo(
        'alertpagebiometrics',
        LocalNotificationIds.values
            .firstWhere((e) => e.toString() == payload.split("-")[1]));
  }

  return null;
}
