// To parse this JSON data, do
//
//     final cocktail = cocktailFromJson(jsonString);

import 'dart:convert';

Cocktail cocktailFromJson(String str) => Cocktail.fromJson(json.decode(str));

String cocktailToJson(Cocktail data) => json.encode(data.toJson());

class Cocktail {
  Cocktail({
    required this.drinks,
  });

  List<Map<String, String>> drinks;

  factory Cocktail.fromJson(Map<String, dynamic> json) => Cocktail(
        drinks: List<Map<String, String>>.from(json["drinks"].map((x) =>
            Map.from(x).map((k, v) =>
                MapEntry<String, String>(k.toString(), v.toString())))),
      );

  Map<String, dynamic> toJson() => {
        "drinks": List<dynamic>.from(drinks.map((x) => Map.from(x).map(
            (k, v) => MapEntry<String, dynamic>(k.toString(), v.toString())))),
      };
}
