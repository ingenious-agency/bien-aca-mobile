import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/components/common/register.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
