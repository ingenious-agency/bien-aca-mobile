import 'package:flutter/material.dart';

class BienAcaConstants extends InheritedWidget {
  static BienAcaConstants of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<BienAcaConstants>();

  const BienAcaConstants({Widget child, Key key})
      : super(key: key, child: child);

  /// Texts
  /// To define a text constant do it following:
  /// final String screennameCapitalisedVarName = "value"
  final String mainTitle = 'BienAcá - Quarent';
  final String homepageTitle = 'This is a String type constant';

  /// Colors
  // ...

  @override
  bool updateShouldNotify(BienAcaConstants oldWidget) => false;
}
