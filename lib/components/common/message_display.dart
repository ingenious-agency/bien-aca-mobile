import 'package:flutter/material.dart';

/// En este archivo se va a hacer display de todos los mensajes, ya sea de exito o una warning/alert.
/// La idea es que se reutilice cada vez que se muestre un mensaje, parametrizando el mismo.
class MessageDisplay extends StatelessWidget {
  const MessageDisplay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Message Display"),
    );
  }
}