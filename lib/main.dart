import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bien_aca_quarantine/service_locator.dart';

import 'package:bien_aca_quarantine/components/pages/inner_page.dart';
import 'package:bien_aca_quarantine/components/pages/home_page.dart';
import 'package:bien_aca_quarantine/components/pages/success_page.dart';
import 'package:bien_aca_quarantine/components/pages/error_page_registration.dart';
import 'package:bien_aca_quarantine/components/pages/error_page_not_authenticated.dart';
import 'package:bien_aca_quarantine/components/pages/alert_page_biometrics.dart';
import 'package:bien_aca_quarantine/components/pages/alert_page_out_of_zone.dart';

import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';
import 'package:bien_aca_quarantine/services/NavigationService.dart';

void main() async {
  setupLocator();
  await DotEnv().load('.env');
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: HomePage(),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case 'innerpage':
            return MaterialPageRoute(builder: (context) => InnerPage());
          case 'successpage':
            return MaterialPageRoute(builder: (context) => SuccessPage());
          case 'alertpageoutofzone':
            return MaterialPageRoute(
                builder: (context) => AlertPageOutOfZone());
          case 'errorpagenotauthenticated':
            return MaterialPageRoute(
                builder: (context) => ErrorPageNotAuthenticated());
          case 'errorpageregistration':
            return MaterialPageRoute(builder: (context) => ErrorPage());
          case 'alertpagebiometrics':
            final AlertPageBiometricsArguments args = routeSettings.arguments;
            return MaterialPageRoute(
                builder: (context) => AlertPageBiometrics(notificationId: args.notificationId));
          default:
            return MaterialPageRoute(builder: (context) => HomePage());
        }
      },
    );
  }
}
