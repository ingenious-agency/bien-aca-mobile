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
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}
