import 'package:bien_aca_quarantine/constants/BienAcaConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BienAcaConstants.of(context).orange,
        body: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.done,
                    color: BienAcaConstants.of(context).blue,
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
                  Navigator.pushReplacementNamed(context, '/innerpage');
                },
                highlightedBorderColor: BienAcaConstants.of(context).blue,
                borderSide: BorderSide(
                  color: BienAcaConstants.of(context).blue,
                  width: 1.2,
                ),
                child: Text('Continuar',
                    style: TextStyle(color: BienAcaConstants.of(context).blue)),
              ),
            ],
          ),
        ));
  }
}
