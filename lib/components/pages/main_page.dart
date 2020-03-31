import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:quarantine_control/services/models/Heartbeat.dart';

import 'package:geolocator/geolocator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LocalAuthentication localAuth = LocalAuthentication();

  StreamSubscription<Position> _positionStreamSubscription;
  final List<Position> _positions = <Position>[];

  bool isFirstInAWhilePositionTrack = true;
  dynamic distanceDyna;

  @override
  void initState() {
    super.initState();
    // _toggleListening();
    // _resetFirstHeartbeat();
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página principal"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Enviar prueba biométrica"),
              onPressed: () {
                _authenticateFingerprint();
              },
            ),
            if (_positions.length > 0) ...[
              Text("${_positions[_positions.length - 1].latitude}"),
              Text("${_positions[_positions.length - 1].longitude}"),
              Text("$distanceDyna"),
            ]
          ],
        ),
      ),
    );
  }

  Future<void> _authenticateFingerprint() async {
    bool authenticated = false;
    try {
      authenticated = await localAuth.authenticateWithBiometrics(
          localizedReason:
              "Utiliza tu huella dactilar para confirmar que eres tú.",
          useErrorDialogs: true,
          stickyAuth: false);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      const LocationOptions locationOptions =
          LocationOptions(accuracy: LocationAccuracy.medium);
      final Stream<Position> positionStream =
          Geolocator().getPositionStream(locationOptions);
      _positionStreamSubscription =
          positionStream.listen((Position position) async {
        Heartbeat currentHeartbeat = await sendHeartbeat(position.latitude,
            position.longitude);
        if (isFirstInAWhilePositionTrack) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("lastLat", currentHeartbeat.lat);
          await prefs.setString("lastLong", currentHeartbeat.lng);
        }
        setState(() {
          _positions.add(position);
          if (isFirstInAWhilePositionTrack)
            isFirstInAWhilePositionTrack = false;
        });
      });
      _positionStreamSubscription.pause();
    }

    setState(() {
      if (_positionStreamSubscription.isPaused) {
        _positionStreamSubscription.resume();
      } else {
        _positionStreamSubscription.pause();
      }
    });
  }

  Future<void> _resetFirstHeartbeat() async {
    await new Future.delayed(const Duration(minutes: 10));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastLat = prefs.getString("lastLat");
    String lastLong = prefs.getString("lastLong");
    if (lastLat.isNotEmpty && lastLong.isNotEmpty) {
      final double distance = await Geolocator().distanceBetween(
          double.parse(lastLat),
          double.parse(lastLong),
          _positions.last.latitude,
          _positions.last.longitude);
      if (distance > 1) {
        // Send alert
      }
      setState(() {
        isFirstInAWhilePositionTrack = true;
        distanceDyna = distance;
      });
    }
    _resetFirstHeartbeat();
  }
}
