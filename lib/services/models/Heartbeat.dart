import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Heartbeat> sendHeartbeat(lat, long) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt("userId");
  // Local
  String baseUrl = 'http://localhost:3000';

  final response = await http.post(
      '$baseUrl/users/$userId/heartbeats',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1ODQ3MTQwOTh9.2aeVZbv6uf2675F4VoYEM7tRLXpDBwE6PMzFzCQS02g"
        },
      body: '{ "time": "${DateTime.now()}", "lat": "$lat", "long": "$long" }');

  if (response.statusCode == 201) {
    Heartbeat heartbeat = Heartbeat.fromJson(json.decode(response.body)["heartbeat"]);
    return heartbeat;
  } else {
    throw Exception('Failed to send the heartbeat');
  }
}

class Heartbeat {
  final int id;
  final int userId;
  final String time;
  final String lat;
  final String lng;
  final bool withinFence;

  Heartbeat(
      {this.id, this.userId, this.time, this.lat, this.lng, this.withinFence});

  factory Heartbeat.fromJson(Map<String, dynamic> json) {
    return Heartbeat(
      id: json['id'],
      userId: json['user_id'],
      time: json['time'],
      lat: json['lat'],
      lng: json['lng'],
      withinFence: json['within_fence'],
    );
  }
}
