import 'package:bien_aca_quarantine/services/BiometricAuthService.dart';
import 'package:bien_aca_quarantine/services/NavigationService.dart';
import 'package:bien_aca_quarantine/services/models/AuthenticationProof.dart';
import 'package:flutter/material.dart';

import 'package:bien_aca_quarantine/components/layouts/design_layout.dart';

import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';

import '../../service_locator.dart';

class AlertPageBiometrics extends StatelessWidget {
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
                      Text(BienAcaConstants.of(context).alertBiometricsTitle,
                          style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RobotoSlab',
                              color: Colors.white)),
                      Container(
                        width: cWidth,
                        child: Text(BienAcaConstants.of(context).alertBiometricsBody,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white)),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              FloatingActionButton(
                onPressed: () async {
                  bool authenticated = await authenticateFingerprint();
                  sendProof(authenticated);
                  if(authenticated) {
                    locator<NavigationService>().navigateTo('innerpage');
                  };
                  locator<NavigationService>().navigateTo('errorpagenotauthenticated');
                  },
                elevation: 0.0,
                backgroundColor: BienAcaConstants.of(context).pink,
                child: Icon(Icons.fingerprint),
              )
            ],
          ),
        )));
  }
}
