/// En este archivo van todos los alerts, con un display utilizando message_display.dart
/// BEAR IN MIND: Flagear display de prueba biometrica; NO UTILIZAR PushReplaceNamed, sino que bloquear el pop con un widget
/// Este Widget es el focus de navigation para el event de sendPush por parte de rails
import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/components/common/register.dart';

class AlertPage extends StatefulWidget {
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  // bool _showRegister;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // _showRegister == true
              /* ? */ Register()
              // : RaisedButton(
              //     child: Text("Registrate para empezar"),
              //     onPressed: () {
              //       setState(() {
              //         _showRegister = true;
              //       });
              //     },
              //   ),
            ],
          ),
        )),
      ),
    );
  }
}
