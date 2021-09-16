import 'package:decision_maker_v1/models/geometry.dart';

class Attraction {
  final Geometry geometry;
  final String name;
  final String address;
  final String rating;
  final List<String> types;

  Attraction(
      {required this.geometry,
      required this.name,
      required this.address,
      required this.rating,
      required this.types});

  factory Attraction.fromJson(Map<String, dynamic> parsedJson) {
    return Attraction(
      geometry: Geometry.fromJson(parsedJson['geometry']),
      name: parsedJson['name'],
      address: parsedJson['formatted_address'],
      rating: parsedJson['rating'].toString(),
      types: List<String>.from(parsedJson['types']),
    );
  }
}
