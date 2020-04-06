import 'dart:async';

import 'package:bien_aca_quarantine/components/common/app_scaffold.dart';
import 'package:bien_aca_quarantine/constants/MyConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bien_aca_quarantine/services/models/Heartbeat.dart';

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
    return AppScaffold(
        AppBody: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 140.0, 20.0, 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Tu ubicación actual!',
                      style: Theme.of(context).textTheme.headline),
                  Text('Latitud: -31.43234 | Longitud: -62.34323',
                      style: Theme.of(context).textTheme.body1),
                  SizedBox(height: 10.0),
                  Text(
                      'En caso de salir de tu zona o no cumplir con las pruebas biométicas, un preaviso te notificará.',
                      style: Theme.of(context).textTheme.body1),
                  SizedBox(height: 10.0),
                  Text(
                      'Si en el lapso de 10 minutos no corregís la situación, una alerta será enviada al centro de control y esta aplicación quedará bloqueada.',
                      style: Theme.of(context).textTheme.body1),
                ],
              )),
        ),
        backgroundColorPage: MyConstants.of(context).lightBlue);
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: Container(
//      child: Center(
//          child: SingleChildScrollView(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            RaisedButton(
//              child: Text("Enviar prueba biométrica"),
//              onPressed: () {
//                _authenticateFingerprint();
//              },
//            ),
//            if (_positions.length > 0) ...[
//              Text("${_positions[_positions.length - 1].latitude}"),
//              Text("${_positions[_positions.length - 1].longitude}"),
//              Text("$distanceDyna"),
//            ]
//          ],
//        ),
//      )),
//    ));
//  }

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
        Heartbeat currentHeartbeat =
            await sendHeartbeat(position.latitude, position.longitude);
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
