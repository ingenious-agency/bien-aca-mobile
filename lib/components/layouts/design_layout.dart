import 'package:flutter/cupertino.dart';
import 'package:bien_aca_quarantine/constants/MyConstants.dart';
import 'package:bien_aca_quarantine/components/common/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class TemplateLayout extends StatelessWidget {

  final String toRender;
  TemplateLayout({this.toRender});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstants.of(context).orange,
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image.asset(
                  'assets/images/quarent-logo.png',
                  width: 100.0,
                )
              ],
            ),
            Row(
              children: <Widget>[
                toRender == 'register' ? Register() : null,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image.asset(
                  'assets/images/bienaca-logo.png',
                  width: 100.0,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

