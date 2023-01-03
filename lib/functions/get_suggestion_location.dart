import 'dart:convert';

import '../assets/apikey.dart';
import '../location.dart';

import 'package:http/http.dart' as http;

Future<Location> getSuggestionLocation(String placeID) async {
  //Response from Place Details API
  final response = await http.get(Uri.parse(
      "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$apiKey"));

  final body = jsonDecode(response.body);

  final Location location =
      Location.fromMap(body["result"]["geometry"]["location"]);

  return location;
}
