import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';
import 'package:bien_aca_quarantine/components/pages/inner_page.dart';
import 'package:bien_aca_quarantine/components/pages/home_page.dart';
import 'package:bien_aca_quarantine/components/pages/success_page.dart';

import 'package:bien_aca_quarantine/services/UserService.dart';
import 'package:bien_aca_quarantine/services/GeofencingService.dart';

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
        addHomeGeofence(user);
        await startGeofencing(10.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/innerpage': (context) => InnerPage(),
        '/successpage': (context) => SuccessPage()
      },
      title: BienAcaConstants.of(context).mainTitle,
      theme: ThemeData(
        fontFamily: 'OpenSans',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoSlab', color: BienAcaConstants.of(context).blue),
          body1: TextStyle(fontSize: 16.0, color: BienAcaConstants.of(context).blue),
        )
      ),
      home: goToInnerPage ? InnerPage() : HomePage(),
    );
  }
}
