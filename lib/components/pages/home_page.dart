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
//    return TemplateLayout(toRender: 'register');
    return Scaffold(
      body: Center(
//        TODO: add conditional if registered, go to main
          child: Register()),
    );
  }
}
