import 'package:bien_aca_quarantine/constants/MyConstants.dart';
import 'package:flutter/material.dart';
import 'package:bien_aca_quarantine/components/common/app_scaffold.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        AppBody: Column(
          children: <Widget>[
            Text('Éxito!', style: Theme.of(context).textTheme.headline),
            Text('Ya sos un usuario de Quarent! Ya estás ayudando!',
                style: Theme.of(context).textTheme.body1),
            OutlineButton(
              onPressed: () {
                print('hiciste click');
              },
              highlightedBorderColor: MyConstants.of(context).blue,
              borderSide: BorderSide(
                color: MyConstants.of(context).blue,
                width: 1.2,
              ) ,
              child: Text('Continuar', style: TextStyle(
                color: MyConstants.of(context).blue
              )),
            ),
          ],
        ),
        backgroundColorPage: MyConstants.of(context).orange);
  }
}
