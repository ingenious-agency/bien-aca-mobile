import 'package:bien_aca_quarantine/components/pages/success_page.dart';
import 'package:bien_aca_quarantine/constants/MyConstants.dart';
import 'package:flutter/material.dart';
import 'package:bien_aca_quarantine/components/common/app_scaffold.dart';
import 'package:flutter/rendering.dart';

class AlertPage extends StatelessWidget {

  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    final AlertPageArguments args = ModalRoute
        .of(context)
        .settings
        .arguments;
    double cWidth = MediaQuery
        .of(context)
        .size
        .width * 0.7;
    return AppScaffold(
        AppBody: Padding(
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
                      Text(args.headlineText,
                          style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RobotoSlab',
                              color: Colors.white)),
                      Container(
                        width: cWidth,
                        child: Text(args.bodyText,
                            style:
                            TextStyle(fontSize: 16.0, color: Colors.white)),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              if (args.doBiometricTest)
                FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/mainpage');
                  },
                    elevation: 0.0,
                    backgroundColor: MyConstants.of(context).pink,
                  child: Icon(Icons.fingerprint, color: Colors.white)
                ),
            ],
          ),
        ),
        backgroundColorPage: MyConstants
            .of(context)
            .lightPink);
  }
}
