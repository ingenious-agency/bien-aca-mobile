import 'package:bien_aca_quarantine/components/pages/alert_page.dart';
import 'package:bien_aca_quarantine/constants/MyConstants.dart';
import 'package:flutter/material.dart';
import 'package:bien_aca_quarantine/components/common/app_scaffold.dart';
import 'package:flutter/rendering.dart';

class SuccessPage extends StatelessWidget {

//  TODO: make this component available to receive parameters in order to make the widget truly common
  @override
  Widget build(BuildContext context) {
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
                    Icons.done,
                    color: MyConstants.of(context).blue,
                    size: 40.0,
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Éxito!',
                          style: Theme.of(context).textTheme.headline),
                      Text('Ya sos un usuario de Quarent!',
                          style: Theme.of(context).textTheme.body1),
                      Text('Ya estás ayudando!',
                          style: Theme.of(context).textTheme.body1),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              OutlineButton(
                onPressed: () {
//                  TODO: use replaceNamed
                  Navigator.pushNamed(context, AlertPage.routeName,
                      arguments: AlertPageArguments('Alerta',
                          'Si dentro de los próximos 10 minutos no volvés a la zona permitida, una alerta será enviada al centro de control.', true));
                },
                highlightedBorderColor: MyConstants.of(context).blue,
                borderSide: BorderSide(
                  color: MyConstants.of(context).blue,
                  width: 1.2,
                ),
                child: Text('Continuar',
                    style: TextStyle(color: MyConstants.of(context).blue)),
              ),
            ],
          ),
        ),
        backgroundColorPage: MyConstants.of(context).orange);
  }
}

// TODO: check if is correct the class here or is best to put somewhere else
class AlertPageArguments {
  final String headlineText;
  final String bodyText;
  final bool doBiometricTest;

  AlertPageArguments(this.headlineText, this.bodyText, this.doBiometricTest);
}
