import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bien_aca_quarantine/services/GeofencingService.dart';

enum Gender { MALE, FEMALE }
final serverUrl = 'https://bian-aca-prod.herokuapp.com';

Future<bool> registerUser(
    Map<String, dynamic> userData, double lat, double lng) async {
  User user = User(
      email: userData['email'],
      name: userData['name'],
      identityNumber: userData['identity_number'],
      dateOfBirth: userData['date_of_birth'],
      gender: userData['gender'] == 'Male' ? Gender.MALE : Gender.FEMALE,
      cellphone: userData['cellphone'],
      password: userData['password'],
      passwordConfirmation: userData['password_confirmation'],
      lat: lat,
      lng: lng);

  final jsonUser = jsonEncode(user);

  final response = await http.post('$serverUrl/users',
      headers: {"Content-Type": "application/json"}, body: jsonUser);

  if (response.statusCode != 201) return false;

  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString("user", response.body);
  
  addHomeGeofence(user);
  await startGeofencing(10.0);
  
  return true;
}

class User {
  final int id;
  final String email;
  final String name;
  final String identityNumber;
  final DateTime dateOfBirth;
  final Gender gender;
  final String cellphone;
  final String password;
  final String passwordConfirmation;
  final double lat;
  final double lng;

  User(
      {this.id,
      this.email,
      this.name,
      this.identityNumber,
      this.dateOfBirth,
      this.gender,
      this.cellphone,
      this.password,
      this.passwordConfirmation,
      this.lat,
      this.lng});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      identityNumber: json['identity_number'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      gender: json['gender'] == 0 ? Gender.MALE : Gender.FEMALE,
      cellphone: json['cellphone'],
      password: null,
      passwordConfirmation: null,
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']));

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': id,
        'email': email,
        'name': name,
        'identity_number': identityNumber,
        'date_of_birth': dateOfBirth.toIso8601String(),
        'password': password,
        'password_confirmation': passwordConfirmation,
        'gender': gender == Gender.MALE ? 0 : 1,
        'cellphone': cellphone,
        'lat': lat,
        'lng': lng
      }
    };
  }
}
