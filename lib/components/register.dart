import 'package:flutter/material.dart';

import 'package:quarantine_control/services/models/User.dart';

import 'package:geolocator/geolocator.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Position _currentPosition;

  List<String> _textFieldsPlaceholders = [
    'Correo electrónico',
    'Nombre',
    'Contraseña',
    'Confirmación de contraseña',
    'Número de documento',
    'Fecha de nacimiento',
    'Género',
    'Número de teléfono',
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...renderForm(),
            RaisedButton(
              child: Text("Registrar"),
              onPressed: () async {
                bool successfulRegister = await registerUser(_currentPosition.latitude, _currentPosition.longitude);
                if (successfulRegister)
                  Navigator.pushReplacementNamed(context, '/mainpage');
              },
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  List<Widget> renderForm() {
    List<Widget> form = _textFieldsPlaceholders.map((placeholder) {
      return TextField(
        keyboardType: TextInputType.number,
        onChanged: (String text) {},
        onSubmitted: (String text) {},
        decoration:
            InputDecoration(border: InputBorder.none, hintText: placeholder),
      );
    }).toList();

    return form;
  }
}
