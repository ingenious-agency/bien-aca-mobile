import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/components/pages/inner_page.dart';
import 'package:bien_aca_quarantine/components/pages/home_page.dart';
import 'package:bien_aca_quarantine/components/pages/success_page.dart';
import 'package:bien_aca_quarantine/components/pages/alert_page.dart';

import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';
import 'package:bien_aca_quarantine/services/UserService.dart';
import 'package:bien_aca_quarantine/services/GeofencingService.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(BienAcaConstants(
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String initialRoute = '/';
  bool goToInnerPage = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser().then((user) async {
      if (await hasCurrentUser()) {
        setState(() {
          initialRoute = '/innerpage';
          goToInnerPage = true;
        });
        addHomeGeofence(user);
        await startGeofencing(10.0);
      }
    });
    setupNotificationPlugin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/innerpage': (context) => InnerPage(),
        '/successpage': (context) => SuccessPage(),
        '/alertpage': (context) => AlertPage(),
      },
      title: BienAcaConstants.of(context).mainTitle,
      theme: ThemeData(
          fontFamily: 'OpenSans',
          textTheme: TextTheme(
            headline: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoSlab',
                color: BienAcaConstants.of(context).blue),
            body1: TextStyle(
                fontSize: 16.0, color: BienAcaConstants.of(context).blue),
          )),
      home: goToInnerPage ? InnerPage() : HomePage(),
    );
  }

//  todo: podríamos sacar el async await
  void setupNotificationPlugin() async {
    FlutterLocalNotificationsPlugin localNotificationInstance =
        FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await localNotificationInstance.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    setState(() {
      flutterLocalNotificationsPlugin = localNotificationInstance;
    });
    print('< ==== i am inside intialization ===>');
    print(localNotificationInstance);
    setupNotification();
  }

  void setupNotification() async {
    print(flutterLocalNotificationsPlugin);
    var time = Time(10, 14, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'show daily title',
        'Daily notification shown at approximately',
        time,
        platformChannelSpecifics);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessPage()),
    );
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuccessPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
