import 'package:flutter/material.dart';

import 'package:quarantine_control/components/pages/home_page.dart';
import 'package:quarantine_control/components/pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/mainpage': (context) => MainPage()
      },
      title: 'Quarantine Control Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}
