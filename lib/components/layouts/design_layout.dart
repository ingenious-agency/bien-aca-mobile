import 'package:flutter/material.dart';

class DesignLayout extends StatelessWidget {
  final Widget content;

  DesignLayout({this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          content,
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'assets/images/bienaca-logo.png',
              width: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}
