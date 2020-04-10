import 'package:bien_aca_quarantine/services/GeofencingService.dart';
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
        addHomeGeofence(user);
        await startGeofencing(10.0, onGeofence: (bg.GeofenceEvent event) async {
          print('<============== bg.GeofenceEvent: $event ==================>');

          var heartbeat = await sendHeartbeat(
              event.location.coords.latitude, event.location.coords.longitude);
          if (heartbeat.withinFence == false) {
            generateInstantNotification(
                BienAcaConstants.of(context).alertPageOutOfZoneTitle,
                BienAcaConstants.of(context).alertPageOutOfZoneTitle);
          }
        });
      }
    });
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
}
