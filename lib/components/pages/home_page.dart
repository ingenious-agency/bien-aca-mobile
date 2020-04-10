import 'package:bien_aca_quarantine/service_locator.dart';
import 'package:bien_aca_quarantine/services/GeofencingService.dart';
import 'package:bien_aca_quarantine/services/LocalNotificationService.dart';
import 'package:bien_aca_quarantine/services/NavigationService.dart';
import 'package:bien_aca_quarantine/services/UserService.dart';
import 'package:bien_aca_quarantine/services/models/Heartbeat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/components/layouts/design_layout.dart';
import 'package:bien_aca_quarantine/components/common/register.dart';

import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    getCurrentUser().then((user) async {
      if (await hasCurrentUser()) {
        locator<NavigationService>().navigateTo('innerpage');
        generateDailyNotification(0, 10, 01, 0, 'doBiometrics');
        generateDailyNotification(0, 16, 02, 0, 'doBiometrics');
        generateDailyNotification(0, 21, 07, 0, 'doBiometrics');
        addHomeGeofence(user);
        await startGeofencing(150.0,
            onGeofence: (bg.GeofenceEvent event) async {
          print('<============== bg.GeofenceEvent: $event ==================>');

          Heartbeat heartbeat = await sendHeartbeat(
              event.location.coords.latitude, event.location.coords.longitude);
          if (heartbeat.withinFence == false) {
            generateInstantNotification(
                'Saliste de la zona',
                'Una alarma ha sido enviada al centro de control.',
                'alertOutOfZone');
            locator<NavigationService>().navigateTo('alertpageoutofzone');
          } else {
            locator<NavigationService>().navigateTo('innerpage');
          }
        });
      }
    });
    initializeLocalNotifications(_onDidReceiveLocalNotification,
        onSelectNotification: (String payload) {
      if (payload == 'doBiometrics') {
        locator<NavigationService>().navigateTo('alertpagebiometrics');
      }
      if (payload == 'alertOutOfZone') {
        locator<NavigationService>().navigateTo('alertpageoutofzone');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BienAcaConstants.of(context).orange,
      body: DesignLayout(
          content: Container(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Register()],
          ),
        )),
      )),
    );
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
              locator<NavigationService>().navigateTo('alertpageoutofzone');
            },
            child: Text('Ok'),
          )
        ],
      ),
    );
  }
}
