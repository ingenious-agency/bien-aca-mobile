import 'package:flutter/material.dart';

import 'package:quarantine_control/components/register.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showRegister;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _showRegister == true
                ? Register()
                : RaisedButton(
                    child: Text("Registrate para empezar"),
                    onPressed: () {
                      setState(() {
                        _showRegister = true;
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
