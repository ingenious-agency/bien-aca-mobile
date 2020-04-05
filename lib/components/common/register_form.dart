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

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 140.0, 20.0, 40.0),
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
              Column(children: <Widget>[
                _textFormFieldCreator('Nombre completo *', nameController),
                _textFormFieldCreator('Email *', emailController),
                _textFormFieldCreator('Contraseña *', passwordController),
                _textFormFieldCreator(
                    'Confirmación contraseña *', passConfirmController),
                _textFormFieldCreator(
                    'Número de identidad *', identityNumberController),
                _textFormFieldCreator(
                    'Fecha Nacimiento *', dateOfBirthController),
                _textFormFieldCreator('Género *', binaryGenderController),
                _textFormFieldCreator('Celular *', cellphoneController),
              ]),
              SizedBox(height: 20.0),
              Align(
                alignment: FractionalOffset.bottomRight,
                child: FlatButton(
                  onPressed: () {
//                    if (_formKey.currentState.validate()) {
                    return Navigator.pushNamed(context, '/success');
//                    }
                  },
                  child: Text('enviar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _textFormFieldCreator(providedFieldName, providedFieldController) {
    return Container(
      height: 60.0,
      child: TextFormField(
        controller: providedFieldController,
        validator: (value) {
          return value.isEmpty ? 'Este dato es requerido' : null;
        },
        decoration: InputDecoration(
          labelText: providedFieldName,
          labelStyle: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
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
    );
  }
}
