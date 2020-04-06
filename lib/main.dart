import 'package:flutter/material.dart';

// TODO: make MyConstants available without import
// TODO: remove unnecessary imports
// TODO: see if there is anything that could be added to ThemeData
import 'package:bien_aca_quarantine/constants/MyConstants.dart';
import 'package:bien_aca_quarantine/components/pages/main_page.dart';
import 'package:bien_aca_quarantine/components/pages/home_page.dart';
import 'package:bien_aca_quarantine/components/pages/success_page.dart';
import 'package:bien_aca_quarantine/components/pages/alert_page.dart';

void main() => runApp(MyConstants(
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/mainpage': (context) => MainPage(),
        '/successpage': (context) => SuccessPage(),
        AlertPage.routeName: (context) => AlertPage(),
      },
      title: MyConstants.of(context).mainTitle,
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'OpenSans',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoSlab', color: MyConstants.of(context).blue),
          body1: TextStyle(fontSize: 16.0, color: MyConstants.of(context).blue),
        )
      ),
    );
  }
}
