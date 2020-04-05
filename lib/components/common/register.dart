import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/services/models/User.dart';
import 'package:flutter/rendering.dart';

import 'package:geolocator/geolocator.dart';

import 'package:bien_aca_quarantine/constants/MyConstants.dart';

import 'package:bien_aca_quarantine/components/common/app_scaffold.dart';
import 'package:bien_aca_quarantine/components/common/register_form.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Position _currentPosition;

  @override
  void initState() {
    super.initState();
//    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(AppBody: RegisterForm(), backgroundColorPage: MyConstants.of(context).orange);
  }
}

//_getCurrentLocation() {
//  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//
//  geolocator
//      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//      .then((Position position) {
//    setState(() {
//      _currentPosition = position;
//    });
//  }).catchError((e) {
//    print(e);
//  });
//}

