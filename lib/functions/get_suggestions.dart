import 'dart:convert';

import '../assets/apikey.dart';
import '../suggestion.dart';
import 'package:http/http.dart' as http;

Future<List<Suggestion>> getSuggestions(String query) async {
  List<Suggestion> suggestions = [];
  //Response from Place AutoComplete API
  final response = await http.get(
    Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey"),
  );

  //Handle status code.
  print(response.statusCode);
  //Response from Place AutoComplete API
  final body = jsonDecode(response.body) as Map<String, dynamic>;

  int recivedSugestions = body["predictions"]!.length;

  for (int i = 0; i < recivedSugestions; i++) {
    suggestions.add(Suggestion.fromMap(body["predictions"]![i]));
  }

  return suggestions;
}
