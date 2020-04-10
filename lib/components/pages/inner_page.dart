import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/components/layouts/design_layout.dart';

import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';

class InnerPage extends StatefulWidget {
  @override
  _InnerPageState createState() => _InnerPageState();
}

class _InnerPageState extends State<InnerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BienAcaConstants.of(context).lightBlue,
      body: DesignLayout(
          content: Container(
        child: Center(
            child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 140.0, 20.0, 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(BienAcaConstants.of(context).innerpageTitle,
                      style: Theme.of(context).textTheme.headline),
                  SizedBox(height: 10.0),
                  Text(BienAcaConstants.of(context).innerpageBody1,
                      style: Theme.of(context).textTheme.body1),
                  SizedBox(height: 10.0),
                  Text(BienAcaConstants.of(context).innerpageBody2,
                      style: Theme.of(context).textTheme.body1),
                ],
              )),
        )),
      )),
    );
  }
}
