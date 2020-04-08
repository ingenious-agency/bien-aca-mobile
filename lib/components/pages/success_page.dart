import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/components/layouts/design_layout.dart';

import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BienAcaConstants.of(context).orange,
        body: DesignLayout(
            content: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.done,
                    color: BienAcaConstants.of(context).blue,
                    size: 40.0,
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(BienAcaConstants.of(context).successpageTitle,
                          style: Theme.of(context).textTheme.headline),
                      Text(BienAcaConstants.of(context).successpageBody1,
                          style: Theme.of(context).textTheme.body1),
                      Text(BienAcaConstants.of(context).successpageBody2,
                          style: Theme.of(context).textTheme.body1),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              OutlineButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/innerpage');
                },
                highlightedBorderColor: BienAcaConstants.of(context).blue,
                borderSide: BorderSide(
                  color: BienAcaConstants.of(context).blue,
                  width: 1.2,
                ),
                child: Text(BienAcaConstants.of(context).successpageButtonLabel,
                    style: TextStyle(color: BienAcaConstants.of(context).blue)),
              ),
            ],
          ),
        )));
  }
}
