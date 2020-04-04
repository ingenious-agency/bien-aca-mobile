import 'package:flutter/material.dart';
import 'package:bien_aca_quarantine/constants/MyConstants.dart';
import 'package:flutter/rendering.dart';


class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {


  final _formKey = GlobalKey<FormState>();
  static final nameController = TextEditingController();
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();
  static final passConfirmController = TextEditingController();
  static final identityNumberController = TextEditingController();
  static final dateOfBirthController = TextEditingController();
  static final binaryGenderController = TextEditingController();
  static final cellphoneController = TextEditingController();

  List providedFields = [
    {'name': 'Nombre completo', 'controller': nameController},
    {'email': 'Email', 'controller': emailController}
    { 'password': 'Contraseña', 'controller': passwordController}
    {
      'passwordConfirmation': 'Confirmá tu contraseñá',
      'controller': passConfirmController
    }
    {
      'identityNumbre': 'Número de identidad',
      'controller': identityNumberController
    }
    { 'dateOfBirth': 'Fecha de nacimiento', 'controller': dateOfBirthController}
    { 'binaryGender': 'Género', 'controller': binaryGenderController}
    { 'cellphone': 'Teléfono', 'controller': cellphoneController}
  ];

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 500.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Registrate!',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline),
            Text(
                'Con tu registro, podremos ayudar a contener el virus y en ningún momento compartimos tus datos personales!.',
                style: Theme
                    .of(context)
                    .textTheme
                    .body1),
            SizedBox(height: 10.0),

            TextFormField(
              controller: nameController,
              validator: (value) {
                return value.isEmpty ? 'Este dato es requerido' : null;
              },
              decoration: InputDecoration(
                labelText: 'Nombre completo *',
                labelStyle: TextStyle(
                  color: MyConstants
                      .of(context)
                      .blue,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: MyConstants
                          .of(context)
                          .blue,
                    )
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomRight,
              child: FlatButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context)
                        .showSnackBar(
                        SnackBar(content: Text('${nameController.text}')));
                  }
                },
                child: Text('enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  class
}
