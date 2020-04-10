import 'package:flutter/material.dart';

class BienAcaConstants extends InheritedWidget {
  static BienAcaConstants of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<BienAcaConstants>();

  BienAcaConstants({Widget child, Key key})
      : super(key: key, child: child);

  /// Colors
  final Color blue = Color(0xFF475985);
  final Color lightBlue = Color(0xFFCDE2DD);
  final Color pink = Color(0xFFC27472);
  final Color lightPink = Color(0xFFEC9390);
  final Color orange = Color(0xFFFFD000);
  final Color green = Color(0xFF9DE2D2);

  /// Texts
  /// To define a text constant do it following:
  /// final String screennameCapitalisedVarName = "value"
  // main.dart
  final String mainTitle = 'BienAcá - Quarent';
  // register.dart
  final String registerTitle = '¡Regístrate!';
  final String registerBody = 'Con tu registro, podremos ayudar a contener el virus. ¡En ningún momento compartimos tus datos personales!.';
  final String registerEmailLabel = 'Email'; 
  final String registerNameLabel = 'Nombre completo'; 
  final String registerIdentityNumberLabel = 'Número de identidad'; 
  final String registerDateOfBirthLabel = 'Fecha de nacimiento'; 
  final String registerPasswordLabel = 'Contraseña'; 
  final String registerPasswordConfirmationLabel = 'Confirmación de contraseña'; 
  final String registerGenderLabel = 'Género'; 
  final String registerCellphoneLabel = 'Número celular'; 
  final String registerButtonLabel = 'Registrar'; 
  final String registerSnackbarLabel = 'Registrando...'; 
  final List<String> registerGenderDropdownItems = ['Masculino', 'Femenino'];
  // success_page.dart
  final String successpageTitle = '¡Éxito!';
  final String successpageBody1 = '¡Ya sos un usuario de Quarent!';
  final String successpageBody2 = '¡Ya estás ayudando!';
  final String successpageButtonLabel = 'Continuar';
  // inner_page.dart
  final String innerpageTitle = '¡Estás en cuarentena!';
  final String innerpageBody1 = 'En caso de salir de tu zona o no cumplir con las pruebas biométicas, un preaviso te notificará.';
  final String innerpageBody2 = 'Si en el lapso de 10 minutos no corregís la situación, una alerta será enviada al centro de control y esta aplicación quedará bloqueada.';
  final String alertPageBodyTitleOutGeofence = 'Saliste de la zona';
  final String alertPageBodyBodyOutGeofence = 'Una alarma ha sido enviada al centro de control';

  @override
  bool updateShouldNotify(BienAcaConstants oldWidget) => false;
}
