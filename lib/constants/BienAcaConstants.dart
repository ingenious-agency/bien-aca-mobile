import 'package:flutter/material.dart';

class BienAcaConstants extends InheritedWidget {
  static BienAcaConstants of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<BienAcaConstants>();

  BienAcaConstants({Widget child, Key key})
      : super(key: key, child: child);

  /// Texts
  /// To define a text constant do it following:
  /// final String screennameCapitalisedVarName = "value"
  final String mainTitle = 'BienAcá - Quarent';
  final String homepageTitle = 'This is a String type constant';

  /// Colors
  final Color blue = Color(0xFF475985);
  final Color lightBlue = Color(0xFFCDE2DD);
  final Color pink = Color(0xFFC27472);
  final Color lightPink = Color(0xFFEC9390);
  final Color orange = Color(0xFFFFD000);
  final Color green = Color(0xFF9DE2D2);

  @override
  bool updateShouldNotify(BienAcaConstants oldWidget) => false;
}
