import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/components/layouts/design_layout.dart';

import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery
        .of(context)
        .size
        .width * 0.7;
    return Scaffold(
        backgroundColor: BienAcaConstants.of(context).lightPink,
        body: DesignLayout(
            content: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.report_problem,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(BienAcaConstants.of(context).errorPageTitle,
                          style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RobotoSlab',
                              color: Colors.white)),
                      Container(
                        width: cWidth,
                        child: Text(BienAcaConstants.of(context).errorPageBody,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white)),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        )));
  }
}
