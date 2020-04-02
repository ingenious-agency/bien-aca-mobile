import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/constants/MyConstants.dart';
import 'package:bien_aca_quarantine/components/pages/main_page.dart';
import 'package:bien_aca_quarantine/components/pages/home_page.dart';
// import 'package:bien_aca_quarantine/components/pages/alert_page.dart';

import 'package:bien_aca_quarantine/services/models/Heartbeat.dart';

import 'package:workmanager/workmanager.dart';
import 'package:geolocator/geolocator.dart';

void callbackDispatcher() {
  Workmanager.executeTask((taskName, map) {
    print("entre al back serv");
    switch (taskName) {
      case "geofencingInBackground":
        print("back serv switch android");
        // /// 1. Get current location
        // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

        // geolocator
        //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        //     .then((Position position) async {
        //   print(position.latitude);
        //   print(position.longitude);
        //   /// 2. Send heartbeat
        //   Heartbeat hb = await sendHeartbeat(position.latitude, position.longitude);
        //   print(hb.id);
        //   print(hb.time);
        //   print(hb.lat);
        //   print(hb.lng);
        // }).catchError((e) {
        //   print(e);
        // });
        break;
      case Workmanager.iOSBackgroundTask:
        print("back serv switch ios");
        // /// 1. Get current location
        // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

        // geolocator
        //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        //     .then((Position position) async {
        //   print(position.latitude);
        //   print(position.longitude);biar y hacer que el geofencing lo haga el front.
Sacando el tiempo de implementación, que ya vemos que es muy difícil llegar para el viernes con todo, que te parece que pueda funcionar mejor de esas dos opciones.
        //   /// 2. Send heartbeat
        //   Heartbeat hb = await sendHeartbeat(position.latitude, position.longitude);
        //   print(hb.id);
        //   print(hb.time);
        //   print(hb.lat);
        //   print(hb.lng);
        // }).catchError((e) {
        //   print(e);
        // });
        break;
    }

    //Return true when the task executed successfully or not
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(callbackDispatcher);
  Workmanager.registerPeriodicTask(
    "1",
    "geofencingInBackground", //This is the value that will be returned in the callbackDispatcher
    initialDelay: Duration(minutes: 1),
    frequency: Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  runApp(MyConstants(
    child: MyApp(),
  ));
}

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
