import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pwcmapassignment/costants.dart';
import 'package:pwcmapassignment/location.dart';
import 'package:pwcmapassignment/suggestion.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  late final TextEditingController searchInputController;

  Future<List<Suggestion>> _getSuggestions(String query) async {
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

  Future<Location> _getSuggestionLocation(String placeID) async {
    //Response from Place Details API
    final response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$apiKey"));

    //Handle status code.
    print(response.statusCode);

    final body = jsonDecode(response.body);

    final Location location =
        Location.fromMap(body["result"]["geometry"]["location"]);

    return location;
  }

  @override
  void initState() {
    searchInputController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition:
              const CameraPosition(target: LatLng(30, 40), zoom: 5),
          mapType: MapType.normal,
          onMapCreated: ((controller) {
            setState(() {
              mapController = controller;
            });
          }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Search",
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(99, 128, 134, 1),
                ),
              ),
            ),
            suggestionsCallback: (query) async {
              return await _getSuggestions(query);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                leading: const Icon(Icons.map),
                title: Text(suggestion.description),
              );
            },
            onSuggestionSelected: (suggestion) async {
              final location = await _getSuggestionLocation(suggestion.placeID);

              await mapController!.animateCamera(
                CameraUpdate.newLatLngZoom(
                    LatLng(location.latitude, location.longitude), 9),
              );
            },
          ),
        )
      ]),
    );
  }
}
