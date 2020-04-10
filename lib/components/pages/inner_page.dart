import 'package:bien_aca_quarantine/services/UserService.dart';
import 'package:bien_aca_quarantine/services/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/components/layouts/design_layout.dart';

import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';
import 'package:bien_aca_quarantine/services/LocalNotificationService.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:bien_aca_quarantine/services/models/Heartbeat.dart';

class InnerPage extends StatefulWidget {
  @override
  _InnerPageState createState() => _InnerPageState();
}

class _InnerPageState extends State<InnerPage> {
  @override
  void initState() {
    super.initState();
    getCurrentUser().then((user) async {
      if (await hasCurrentUser()) {
        _addHomeGeofence(user);
        await _startGeofencing(10.0);
      }
    });
    initializeLocalNotifications(_onDidReceiveLocalNotification);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BienAcaConstants.of(context).lightBlue,
      body: DesignLayout(
          content: Container(
        child: Center(
            child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 140.0, 20.0, 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(BienAcaConstants.of(context).innerpageTitle,
                      style: Theme.of(context).textTheme.headline),
                  SizedBox(height: 10.0),
                  Text(BienAcaConstants.of(context).innerpageBody1,
                      style: Theme.of(context).textTheme.body1),
                  SizedBox(height: 10.0),
                  Text(BienAcaConstants.of(context).innerpageBody2,
                      style: Theme.of(context).textTheme.body1),
                ],
              )),
        )),
      )),
    );
  }

  void _addHomeGeofence(User user) {
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
  }

//  void _removeHomeGeofence(User user) {
//    bg.BackgroundGeolocation.removeGeofence('Home').then((bool success) {
//      print('[removeGeofence] success');
//    });
//  }

  Future<void> _startGeofencing(double distance) async {
    BuildContext context;
    bool homeReady = await bg.BackgroundGeolocation.geofenceExists("Home");
    if (!homeReady) return;

    await bg.BackgroundGeolocation.ready(bg.Config(
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter: distance,
            stopOnTerminate: false,
            startOnBoot: true,
            debug: true,
            heartbeatInterval: 60,
            preventSuspend: true,
            logLevel: bg.Config.LOG_LEVEL_VERBOSE))
        .then((bg.State state) {
      print("<========= state bgGeolocation: $state ============>");

      if (!state.enabled) {
        bg.BackgroundGeolocation.start();
      }
    });

    bg.BackgroundGeolocation.onGeofence((bg.GeofenceEvent event) async {
      print('<============== bg.GeofenceEvent: $event ==================>');

      Heartbeat heartbeat = await sendHeartbeat(
          event.location.coords.latitude, event.location.coords.longitude);

      if (heartbeat.withinFence == false) {
        generateInstantNotification(
            BienAcaConstants.of(context).alertPageBodyTitleOutGeofence,
            BienAcaConstants.of(context).alertPageBodyBodyOutGeofence);
        Navigator.pushReplacementNamed(context, '/alertpage');
      }
    });
  }

  Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () async {
              print("On pressed");
            },
            child: Text('Ok'),
          )
        ],
      ),
    );
  }
}
