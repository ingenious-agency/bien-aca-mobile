import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';
import 'package:bien_aca_quarantine/components/pages/inner_page.dart';
import 'package:bien_aca_quarantine/components/pages/home_page.dart';

import 'package:bien_aca_quarantine/services/UserService.dart';
import 'package:bien_aca_quarantine/services/GeofencingService.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      },
      title: BienAcaConstants.of(context).mainTitle,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: goToInnerPage ? InnerPage() : HomePage(),
    );
  }
}
