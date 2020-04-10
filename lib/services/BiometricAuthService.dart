import 'package:local_auth/local_auth.dart';

Future<bool> authenticateFingerprint() async {
    LocalAuthentication localAuth = LocalAuthentication();
    
    bool authenticated = false;
    try {
      authenticated = await localAuth.authenticateWithBiometrics(
          localizedReason:
              "Utiliza tu huella dactilar para confirmar que eres tú.",
          useErrorDialogs: true,
          stickyAuth: false);
    } on Error catch (e) {
      print(e);
      return false;
    }
    return authenticated;
  }