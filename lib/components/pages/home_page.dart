import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';
import 'package:flutter/material.dart';
import 'package:bien_aca_quarantine/components/common/register.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BienAcaConstants.of(context).orange,
      body: Container(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Register()],
          ),
        )),
      ),
    );
  }
}
