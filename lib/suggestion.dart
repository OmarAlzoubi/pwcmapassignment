import 'dart:convert';

class Suggestion {
  String description;
  String placeID;
  Suggestion({
    required this.description,
    required this.placeID,
  });

  factory Suggestion.fromMap(Map map) {
    return Suggestion(
      description: map['description'] ?? '',
      placeID: map['place_id'] ?? '',
    );
  }
}
