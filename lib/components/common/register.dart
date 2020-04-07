import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Text('Registrate!', style: Theme.of(context).textTheme.headline),
              Text(
                  'Con tu registro, podremos ayudar a contener el virus y en ningún momento compartimos tus datos personales!.',
                  style: Theme.of(context).textTheme.body1),
              SizedBox(height: 10.0),
              FormBuilderTextField(
                attribute: "email",
                decoration: InputDecoration(
                  labelText: "Email",
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
                  labelText: "Full name",
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
                  labelText: "Identity number",
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
                  labelText: "Date of birth",
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
                  labelText: "Password",
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
                  labelText: "Password confirmation",
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
                  labelText: "Gender",
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
                decoration: InputDecoration(
                  labelText: "Cellphone",
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
                  child: Text("Register"),
                  onPressed: () async {
                    if (_fbKey.currentState.saveAndValidate()) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Registering...')));

                      bool success = await registerUser(
                          _fbKey.currentState.value,
                          _currentPosition.latitude,
                          _currentPosition.longitude);
                      if (success) {
                        Navigator.pushReplacementNamed(context, '/successpage');
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                'Opss... Something went wrong registering the user')));
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
