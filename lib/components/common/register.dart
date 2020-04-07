import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:bien_aca_quarantine/services/models/User.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _setCurrentLocation();
  }

  void _setCurrentLocation() {
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

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      autovalidate: false,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormBuilderTextField(
                attribute: "email",
                decoration: InputDecoration(labelText: "Email"),
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email()
                ],
              ),
              FormBuilderTextField(
                attribute: "name",
                decoration: InputDecoration(labelText: "Full name"),
                validators: [FormBuilderValidators.required()],
              ),
              FormBuilderTextField(
                attribute: "identity_number",
                decoration: InputDecoration(labelText: "Identity number"),
                validators: [FormBuilderValidators.required()],
              ),
              FormBuilderDateTimePicker(
                attribute: "date_of_birth",
                inputType: InputType.date,
                decoration: InputDecoration(labelText: "Date of birth"),
                validators: [FormBuilderValidators.required()],
              ),
              FormBuilderTextField(
                attribute: "password",
                decoration: InputDecoration(labelText: "Password"),
                validators: [FormBuilderValidators.required()],
                obscureText: true,
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
              ),
              FormBuilderTextField(
                attribute: "password_confirmation",
                decoration: InputDecoration(labelText: "Password confirmation"),
                validators: [FormBuilderValidators.required()],
                obscureText: true,
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
              ),
              FormBuilderDropdown(
                attribute: "gender",
                decoration: InputDecoration(labelText: "Gender"),
                initialValue: 'Male',
                hint: Text('Select Gender'),
                validators: [FormBuilderValidators.required()],
                items: ['Male', 'Female']
                    .map((gender) =>
                        DropdownMenuItem(value: gender, child: Text("$gender")))
                    .toList(),
              ),
              FormBuilderTextField(
                attribute: "cellphone",
                decoration: InputDecoration(labelText: "Cellphone"),
                validators: [FormBuilderValidators.required()],
              ),
              RaisedButton(
                child: Text("Register"),
                onPressed: () async {
                  if (_fbKey.currentState.saveAndValidate()) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Registering...')));

                    bool success = await registerUser(_fbKey.currentState.value,
                        _currentPosition.latitude, _currentPosition.longitude);
                    if (success) {
                      Navigator.pushReplacementNamed(context, '/innerpage');
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                              'Opss... Something went wrong registering the user')));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
