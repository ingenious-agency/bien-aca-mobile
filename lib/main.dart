import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:bien_aca_quarantine/components/pages/inner_page.dart';
import 'package:bien_aca_quarantine/components/pages/home_page.dart';
import 'package:bien_aca_quarantine/components/pages/success_page.dart';
import 'package:bien_aca_quarantine/components/pages/error_page_registration.dart';
import 'package:bien_aca_quarantine/components/pages/alert_page_biometrics.dart';
import 'package:bien_aca_quarantine/components/pages/alert_page_out_of_zone.dart';

import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';
import 'package:bien_aca_quarantine/services/UserService.dart';
import 'package:bien_aca_quarantine/services/GeofencingService.dart';
import 'package:bien_aca_quarantine/services/LocalNotificationService.dart';

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
  String initialRoute = '/';
  bool goToInnerPage = false;


  Future<void> onSelectNotification(String payload) {
    if (payload != null) {}
  }

  Future onDidReceiveLocalNotification(int id, String title, String body,
      String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("On Pressed");
            },
            child: Text("Okay")),
      ],
    );
  }


  @override
  void initState() {
    super.initState();
    initializeLocalNotifications(
        onDidReceiveLocalNotification, onSelectNotification);
    getCurrentUser().then((user) async {
      if (await hasCurrentUser()) {
        setState(() {
          initialRoute = '/innerpage';
          goToInnerPage = true;
        });
      }
    });


    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        initialRoute: initialRoute,
        routes: {
      '/innerpage': (context) => InnerPage(),
      '/successpage': (context) => SuccessPage(),
      '/errorpageregistration': (context) => ErrorPage(),
      '/alertpageoutofzone': (context) => AlertPageOutOfZone(),
      '/biometrics': (context) => AlertPageOutOfZone(),
      '/alertpagebiometrics': (context) => AlertPageBiometrics(),
      },
        title: BienAcaConstants
            .of(context)
            .mainTitle,
        theme: ThemeData(
            fontFamily: 'OpenSans',
            textTheme: TextTheme(
              headline: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoSlab',
                  color: BienAcaConstants
                      .of(context)
                      .blue),
              body1: TextStyle(
                  fontSize: 16.0, color: BienAcaConstants
                  .of(context)
                  .blue),
            )),
        home: goToInnerPage ? InnerPage() : HomePage(),
      );
    }

    Future _onDidReceiveLocalNotification(int id, String title, String body,
        String payload) async {
      // display a dialog with the notification details, tap ok to go to another page
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    print("On pressed");
                  },
                  child: Text('Ok'),
                )
              ],
            ),
      );
    }
  }
