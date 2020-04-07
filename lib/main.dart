import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';
import 'package:bien_aca_quarantine/components/pages/inner_page.dart';
import 'package:bien_aca_quarantine/components/pages/home_page.dart';

import 'package:bien_aca_quarantine/services/models/Heartbeat.dart';
import 'package:bien_aca_quarantine/services/models/User.dart';

String initialRoute = '/';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.getInstance().then((prefs) {
    String userValue = prefs.getString("user");
    if (userValue == null) return Future.value(null);

    User user;
    try {
      user = User.fromJson(jsonDecode(userValue));
    } catch (e) {}

    if (user != null) {
      initialRoute = '/innerpage';

      bg.BackgroundGeolocation.addGeofence(bg.Geofence(
        identifier: "Home",
        radius: 10,
        latitude: user.lat,
        longitude: user.lng,
        notifyOnEntry: true,
        notifyOnExit: true,
        notifyOnDwell: true,
        loiteringDelay: 15000, // 15 secs
      )).then((bool success) {
        print('[addGeofence] success');
      }).catchError((error) {
        print('[addGeofence] FAILURE: $error');
      });

      bg.BackgroundGeolocation.ready(bg.Config(
              desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
              distanceFilter: 10.0,
              stopOnTerminate: false,
              startOnBoot: true,
              debug: true,
              heartbeatInterval: 60,
              preventSuspend: true,
              logLevel: bg.Config.LOG_LEVEL_VERBOSE))
          .then((bg.State state) {
        if (!state.enabled) {
          bg.BackgroundGeolocation.start();
        }
      });

      bg.BackgroundGeolocation.onGeofence((bg.GeofenceEvent event) {
        sendHeartbeat(
            event.location.coords.latitude, event.location.coords.longitude);
      });
    }
    return Future.value(null);
  });

  runApp(BienAcaConstants(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
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
      home: HomePage(),
    );
  }
}
