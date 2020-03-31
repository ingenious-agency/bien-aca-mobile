import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum BinaryGender { MALE, FEMALE }

Future<bool> registerUser(lat, long) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Local
  String registerUserJson =
      '{ "user": { "email": "emailTest@testing.com", "name": "Test User", "password": "testtest",  "password_confirmation": "testtest", "identity_number": "3.482.204-2", "date_of_birth": "1984-03-20", "binary_gender": 0, "cellphone": "099275434", "lat": "$lat", "long": "$long" } }';
  String baseUrl = 'http://localhost:3000';

  final response = await http.post(
      '$baseUrl/users',
      headers: {"Content-Type": "application/json"},
      body: registerUserJson);

  if (response.statusCode == 201) {
    User user = User.fromJson(json.decode(response.body));
    // Store user data in shared preferences to use as future requests payload
    await prefs.setInt("userId", user.id);
    await prefs.setString("userIdentityNumber", user.identityNumber);
    await prefs.setString("userName", user.name);
    await prefs.setString("userCellphone", user.cellphone);
    return true;
  } else {
    throw Exception('Failed to register user');
  }
}

class User {
  final int id;
  final String email;
  final String name;
  final String identityNumber;
  final String dateOfBirth;
  final BinaryGender gender;
  final String cellphone;
  final String password;

  User(
      {this.id,
      this.email,
      this.name,
      this.identityNumber,
      this.dateOfBirth,
      this.gender,
      this.cellphone,
      this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      identityNumber: json['identity_number'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'] == "male"
          ? BinaryGender.MALE
          : BinaryGender.FEMALE,
      cellphone: json['cellphone'],
      password: json['password'],
    );
  }
}
