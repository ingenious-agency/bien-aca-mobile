import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/services/models/User.dart';
import 'package:flutter/rendering.dart';

import 'package:geolocator/geolocator.dart';

import 'package:bien_aca_quarantine/constants/MyConstants.dart';

import 'app_scaffold.dart';

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

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 500.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Necesitamos tu nombre completo';
                }
                return null;
              },
            ),
            FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('procesando data')));
                }
              },
              child: Text('enviar'),
            )
          ],
        ),
      ),
    );
  }
}
