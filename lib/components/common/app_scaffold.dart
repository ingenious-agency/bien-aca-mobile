import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class AppScaffold extends StatelessWidget {

  final Widget AppBody;
  final Color backgroundColorPage;

  AppScaffold({this.AppBody, this.backgroundColorPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColorPage,
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/images/quarent-logo-blanco.png',
                  width: 100.0,
                ),
              ),
              Center(child: AppBody),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/images/bienaca-logo.png',
                  width: 100.0,
                ),
              ),
            ],
          ),
        )
    );
  }
}