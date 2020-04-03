import 'package:flutter/material.dart';
import 'package:bien_aca_quarantine/constants/MyConstants.dart';
import 'package:flutter/rendering.dart';


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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Registrate!',
              style: Theme.of(context).textTheme.headline),
            Text('Vas a poder establecer tu zona de cuarentena, geolocalizarte y geolocalizar tu celular!', style: Theme.of(context).textTheme.body1),
            Text('Todo esto, sin compartir a nadie tus datos personales!', style: Theme.of(context).textTheme.body1),
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
