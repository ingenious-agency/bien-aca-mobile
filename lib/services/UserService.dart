import 'dart:convert';

import 'package:bien_aca_quarantine/services/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userValue = prefs.getString("user");
  if (userValue == null) return Future.value(null);

  User user;
  try {
    user = User.fromJson(jsonDecode(userValue));
  } catch (e) {}

  return user;
}

Future<bool> hasCurrentUser() async {
  return await getCurrentUser() != null;
}
