import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bien_aca_quarantine/services/models/User.dart';

final serverUrl = 'https://bian-aca-prod.herokuapp.com';

Future<AuthenticationProof> sendProof(authenticated) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = User.fromJson(jsonDecode(prefs.getString("user")));
  if (user == null) return Future.value(null);

  AuthenticationProof authenticationProof = AuthenticationProof(
      userId: user.id, time: DateTime.now(), authenticated: authenticated);

  final jsonAuthenticationProof = jsonEncode(authenticationProof);

  final response = await http.post(
      '$serverUrl/users/${user.id}/authentication_proofs',
      headers: {"Content-Type": "application/json"},
      body: jsonAuthenticationProof);

  if (response.statusCode == 201) {
    return Future.value(authenticationProof);
  } else {
    throw Exception('Failed to send the authentication proof');
  }
}

class AuthenticationProof {
  final int id;
  final int userId;
  final DateTime time;
  final bool authenticated;

  AuthenticationProof({this.id, this.userId, this.time, this.authenticated});

  Map<String, dynamic> toJson() {
    return {
      'authentication_proof': {
        'id': id,
        'time': time.toIso8601String(),
        'authenticated': authenticated
      }
    };
  }
}
