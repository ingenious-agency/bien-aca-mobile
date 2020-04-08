import 'package:bien_aca_quarantine/services/models/Heartbeat.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:bien_aca_quarantine/services/models/User.dart';

void addHomeGeofence(User user) {
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

Future<void> startGeofencing(double distance) async {
  bool homeReady = await bg.BackgroundGeolocation.geofenceExists("Home");
  if (!homeReady) return;

  bg.BackgroundGeolocation.ready(bg.Config(
          desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
          distanceFilter: distance,
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
