import 'dart:convert';

//Use it after getting the list of auto completes
//https://maps.googleapis.com/maps/api/place/details/json?place_id=&key=
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:http/http.dart' as http;

class SearchCityScreen extends StatelessWidget {
  const SearchCityScreen({super.key});

  Future<void> _callApi() async {
    final response = await http.get(
      Uri.parse(
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=amman&key=AIzaSyBnZjVDyRLjyKib5CypWZ50R1LvgLqvx6M"),
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    print(body["predictions"][0]["description"]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: (() async {
          await _callApi();
        }),
        child: const Text("Send API Call"),
      ),
    );
  }
}
