import 'package:flutter/material.dart';

class MyConstants extends InheritedWidget {
  static MyConstants of(BuildContext context) => context. dependOnInheritedWidgetOfExactType<MyConstants>();

  const MyConstants({Widget child, Key key}): super(key: key, child: child);

  /**
   * Texts
   * To define a text constant do it following:
   * final String screennameCapitalisedVarName = "value"
   */
  final String mainTitle = 'BienAcá - Quarent';
  final String homepageTitle = 'This is a String type constant';

  // Colors
  // ...

  /// TODOS
  /// - Estructurar proyecto
  ///  - Terminar de definir consts de textos que ya existen
  ///  - Definir las pantallas a crear
  ///  - Definir rutas de pantallas (progresivamente)
  ///  - Definir componentes common
  /// - Generar launcher icons
  /// - Post 14:
  ///  - Investigar Layout para logo y footer
  /// - Diseño UI
  ///  - Mergear con tareas en sprint actual
  /// BEAR IN MIND
  /// - Necesitamos un callback para el evento de sendPush por el Backend

  @override
  bool updateShouldNotify(MyConstants oldWidget) => false;
}