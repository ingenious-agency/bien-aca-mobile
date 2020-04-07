import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';
import 'package:flutter/material.dart';

class InnerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BienAcaConstants.of(context).lightBlue,
      body: Container(
        child: Center(
            child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 140.0, 20.0, 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Estás en cuarentena!',
                      style: Theme.of(context).textTheme.headline),
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
        )),
      ),
    );
  }
}
