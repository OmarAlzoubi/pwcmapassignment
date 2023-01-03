import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'functions/get_suggestions.dart';
import 'functions/get_suggestion_location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  late final TextEditingController searchInputController;

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
              return await getSuggestions(query);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                leading: const Icon(Icons.map),
                title: Text(suggestion.description),
              );
            },
            onSuggestionSelected: (suggestion) async {
              final location = await getSuggestionLocation(suggestion.placeID);

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
