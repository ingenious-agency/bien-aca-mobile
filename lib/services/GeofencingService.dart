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

void removeHomeGeofence(User user) {
  bg.BackgroundGeolocation.removeGeofence('Home').then((bool success) {
    print('[removeGeofence] success');
  });
}

Future<void> onGeofence(bg.GeofenceEvent event) async {
  print('<============== bg.GeofenceEvent: $event ==================>');

  await sendHeartbeat(
      event.location.coords.latitude, event.location.coords.longitude);
}

Future<void> startGeofencing(double distance, {onGeofence = onGeofence}) async {
  bool homeReady = await bg.BackgroundGeolocation.geofenceExists("Home");
  if (!homeReady) return;

  await bg.BackgroundGeolocation.ready(bg.Config(
          desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
          distanceFilter: distance,
          geofenceInitialTriggerEntry: true,
          stopOnTerminate: false,
          startOnBoot: true,
          debug: false,
          heartbeatInterval: 1800, // Half an hour
          preventSuspend: true,
          logLevel: bg.Config.LOG_LEVEL_VERBOSE))
      .then((bg.State state) {
    print("<========= state bgGeolocation: $state ============>");

    if (!state.enabled) {
      bg.BackgroundGeolocation.start();
    }
  });

  bg.BackgroundGeolocation.onGeofence(onGeofence);

  bg.BackgroundGeolocation.onHeartbeat((bg.HeartbeatEvent event) async {
    try {
      await sendHeartbeat(
          event.location.coords.latitude, event.location.coords.longitude,
          data: {'isAliveHeartbeat': true});
    } catch (e) {}
  });
}
