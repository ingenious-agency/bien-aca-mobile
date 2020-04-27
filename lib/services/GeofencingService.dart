import 'package:bien_aca_quarantine/services/models/Heartbeat.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:bien_aca_quarantine/services/models/User.dart';
import 'package:bien_aca_quarantine/services/LocalNotificationService.dart';

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

  bg.Location currentLocation =
      await bg.BackgroundGeolocation.getCurrentPosition();
  // Send initial heartbeat and schedule first lost-heartbeat local notification
  generateScheduledNotification(LocalNotificationIds.lostHeartbeatScheduled,
      hours: 0,
      minutes: 35, // Heartbeat rate + 5min
      seconds: 0,
      payload: "lost-heartbeat",
      title: "Pérdida de conexión",
      body:
          "¡No estás enviando señales de vida! Revise su conexión a internet y acceso a GPS");
  await sendHeartbeat(
      currentLocation.coords.latitude, currentLocation.coords.longitude,
      data: {'isAliveHeartbeat': true});

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
    print('<============== bg.OnHeartbeat: $event ==================>');
    try {
      generateScheduledNotification(LocalNotificationIds.lostHeartbeatScheduled,
          hours: 0,
          minutes: 35, // Heartbeat rate + 5min
          seconds: 0,
          payload: "lost-heartbeat",
          title: "Pérdida de conexión",
          body:
              "¡No estás enviando señales de vida! Revise su conexión a internet y acceso a GPS");
      await sendHeartbeat(
          event.location.coords.latitude, event.location.coords.longitude,
          data: {'isAliveHeartbeat': true});
    } catch (e) {}
  });

  bg.BackgroundGeolocation.onConnectivityChange(
      (bg.ConnectivityChangeEvent event) {
    if (!event.connected) {
      // Send notification for loss of connectivity
      generateInstantNotification(
          LocalNotificationIds.lostConnectivityInstant,
          "Pérdida de conexión",
          "Revisa tu conexión a internet.",
          "lost-connectivity");
    }
  });

  bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
    if (!event.gps) {
      // Send notification for loss of gps
      generateInstantNotification(LocalNotificationIds.lostGpsInstant,
          "Pérdida de GPS", "Revisa tu acceso a GPS.", "lost-gps");
    }
  });
}
