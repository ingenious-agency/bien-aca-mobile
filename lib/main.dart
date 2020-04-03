import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/constants/MyConstants.dart';
import 'package:bien_aca_quarantine/components/pages/main_page.dart';
import 'package:bien_aca_quarantine/components/pages/home_page.dart';
// import 'package:bien_aca_quarantine/components/pages/alert_page.dart';

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
        // '/alertpage': (context) => AlertPage(),
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
