import 'package:flutter/material.dart';
import 'package:pwcmapassignment/routes.dart';

import 'map_screen.dart';
import 'search_city_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PWC Assignment",
      home: MapScreen(),
      routes: {
        mapScreenRoute: ((context) => const MapScreen()),
        searchCityScreenRoute: (context) => const SearchCityScreen(),
      },
    );
  }
}
