import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bien_aca_quarantine/services/models/User.dart';

final serverUrl = 'http://10.0.2.2:3000';

Future<Heartbeat> sendHeartbeat(lat, lng) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = User.fromJson(jsonDecode(prefs.getString("user")));
  if (user == null) return Future.value(null);

  Heartbeat heartbeat = Heartbeat(
      userId: user.id,
      time: DateTime.now().toIso8601String(),
      lat: lat,
      lng: lng);

  final jsonHeartbeat = jsonEncode(heartbeat);

  final response = await http.post('$serverUrl/users/${user.id}/heartbeats',
      headers: {"Content-Type": "application/json"}, body: jsonHeartbeat);

  if (response.statusCode == 201) {
    Heartbeat heartbeat =
        Heartbeat.fromJson(json.decode(response.body)["heartbeat"]);
    return Future.value(heartbeat);
  } else {
    throw Exception('Failed to send the heartbeat');
  }
}

class Heartbeat {
  final int id;
  final int userId;
  final String time;
  final double lat;
  final double lng;
  final bool withinFence;

  Heartbeat(
      {this.id, this.userId, this.time, this.lat, this.lng, this.withinFence});

  factory Heartbeat.fromJson(Map<String, dynamic> json) {
    return Heartbeat(
      id: json['id'],
      userId: json['user_id'],
      time: json['time'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
      withinFence: json['within_fence'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'heartbeat': {
        'id': id,
        'time': time,
        'lat': lat,
        'lng': lng,
      }
    };
  }
}
