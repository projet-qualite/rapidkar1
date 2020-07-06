// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

Favorite favoriteFromJson(String str) => Favorite.fromJson(json.decode(str));

String favoriteToJson(Favorite data) => json.encode(data.toJson());

class Favorite {
  Favorite({
    this.id,
    this.car,
    this.fan
  });

  int id;
  int car;
  int fan;

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json["id"],
    car: json["car"],
    fan: json["fan"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "car": car,
    "fan": fan,
  };
}
