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

  @override
  void initState() {
    super.initState();
    getCurrentUser().then((user) async {
      if (await hasCurrentUser()) {
        setState(() {
          initialRoute = '/innerpage';
          goToInnerPage = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/innerpage': (context) => InnerPage(),
        '/successpage': (context) => SuccessPage(),
        '/errorpageregistration': (context) => ErrorPage(),
        '/alertpageoutofzone': (context) => AlertPageOutOfZone(),
        '/alertpagebiometrics': (context) => AlertPageBiometrics(),
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
}