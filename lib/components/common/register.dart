import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Text(BienAcaConstants.of(context).registerTitle, style: Theme.of(context).textTheme.headline),
              Text(
                  BienAcaConstants.of(context).registerBody,
                  style: Theme.of(context).textTheme.body1),
              SizedBox(height: 10.0),
              FormBuilderTextField(
                attribute: "email",
                decoration: InputDecoration(
                  labelText: BienAcaConstants.of(context).registerEmailLabel,
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: BienAcaConstants.of(context).blue,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: BienAcaConstants.of(context).blue,
                  )),
                ),
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email()
                ],
              ),
              FormBuilderTextField(
                attribute: "name",
                decoration: InputDecoration(
                  labelText: BienAcaConstants.of(context).registerNameLabel,
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: BienAcaConstants.of(context).blue,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: BienAcaConstants.of(context).blue,
                  )),
                ),
                validators: [FormBuilderValidators.required()],
              ),
              FormBuilderTextField(
                attribute: "identity_number",
                decoration: InputDecoration(
                  labelText: BienAcaConstants.of(context).registerIdentityNumberLabel,
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: BienAcaConstants.of(context).blue,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: BienAcaConstants.of(context).blue,
                  )),
                ),
                validators: [FormBuilderValidators.required()],
              ),
              FormBuilderDateTimePicker(
                attribute: "date_of_birth",
                inputType: InputType.date,
                decoration: InputDecoration(
                  labelText: BienAcaConstants.of(context).registerDateOfBirthLabel,
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: BienAcaConstants.of(context).blue,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: BienAcaConstants.of(context).blue,
                  )),
                ),
                validators: [FormBuilderValidators.required()],
              ),
              FormBuilderTextField(
                attribute: "password",
                decoration: InputDecoration(
                  labelText: BienAcaConstants.of(context).registerPasswordLabel,
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: BienAcaConstants.of(context).blue,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: BienAcaConstants.of(context).blue,
                  )),
                ),
                validators: [FormBuilderValidators.required()],
                obscureText: true,
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
              ),
              FormBuilderTextField(
                attribute: "password_confirmation",
                decoration: InputDecoration(
                  labelText: BienAcaConstants.of(context).registerPasswordConfirmationLabel,
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: BienAcaConstants.of(context).blue,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: BienAcaConstants.of(context).blue,
                  )),
                ),
                validators: [FormBuilderValidators.required()],
                obscureText: true,
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
              ),
              FormBuilderDropdown(
                attribute: "gender",
                decoration: InputDecoration(
                  labelText: BienAcaConstants.of(context).registerGenderLabel,
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: BienAcaConstants.of(context).blue,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: BienAcaConstants.of(context).blue,
                  )),
                ),
                initialValue: BienAcaConstants.of(context).registerGenderDropdownItems[0],
                validators: [FormBuilderValidators.required()],
                items: BienAcaConstants.of(context).registerGenderDropdownItems
                    .map((gender) =>
                        DropdownMenuItem(value: gender, child: Text("$gender")))
                    .toList(),
              ),
              FormBuilderTextField(
                attribute: "cellphone",
                decoration: InputDecoration(
                  labelText: BienAcaConstants.of(context).registerCellphoneLabel,
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: BienAcaConstants.of(context).blue,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: BienAcaConstants.of(context).blue,
                  )),
                ),
                validators: [FormBuilderValidators.required()],
              ),
              Align(
                alignment: FractionalOffset.bottomRight,
                child: FlatButton(
                  child: Text(BienAcaConstants.of(context).registerButtonLabel),
                  onPressed: () async {
                    if (_fbKey.currentState.saveAndValidate()) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text(BienAcaConstants.of(context).registerSnackbarLabel)));

                      bool success = await registerUser(
                          _fbKey.currentState.value,
                          _currentPosition.latitude,
                          _currentPosition.longitude);
                      if (success) {
                        Navigator.pushReplacementNamed(context, '/successpage');
                      } else {
                        Navigator.pushNamed(context, '/errorpageregistration');
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
