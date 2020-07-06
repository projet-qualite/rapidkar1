// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  Car({
    this.id,
    this.brand,
    this.model,
    this.numberplate,
    this.gearshift,
    this.fuel,
    this.places,
    this.doors,
    this.lastCtrlDate,
    this.loan,
    this.insurance,
    this.driver,
    this.location,
    this.age,
    this.owner,
    this.tocall,
    this.available,
    this.img1,
    this.img2,
    this.img3,
    this.img4,
    this.img5,
  });

  int id;
  String brand;
  String model;
  String numberplate;
  String gearshift;
  String fuel;
  int places;
  int doors;
  DateTime lastCtrlDate;
  int loan;
  int insurance;
  int driver;
  String location;
  int age;
  int owner;
  String tocall;
  int available;
  String img1;
  String img2;
  String img3;
  String img4;
  String img5;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["id"],
    brand: json["brand"],
    model: json["model"],
    numberplate: json["numberplate"],
    gearshift: json["gearshift"],
    fuel: json["fuel"],
    places: json["places"],
    doors: json["doors"],
    lastCtrlDate: DateTime.parse(json["lastCtrlDate"]),
    loan: json["loan"],
    insurance: json["insurance"],
    driver: json["driver"],
    location: json["location"],
    age: json["age"],
    owner: json["owner"],
    tocall: json["tocall"],
    available: json["available"],
    img1: json["img_1"],
    img2: json["img_2"],
    img3: json["img_3"],
    img4: json["img_4"],
    img5: json["img_5"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand": brand,
    "model": model,
    "numberplate": numberplate,
    "gearshift": gearshift,
    "fuel": fuel,
    "places": places,
    "doors": doors,
    "lastCtrlDate": "${lastCtrlDate.year.toString().padLeft(4, '0')}-${lastCtrlDate.month.toString().padLeft(2, '0')}-${lastCtrlDate.day.toString().padLeft(2, '0')}",
    "loan": loan,
    "insurance": insurance,
    "driver": driver,
    "location": location,
    "age": age,
    "owner": owner,
    "tocall": tocall,
    "available": available,
    "img_1": img1,
    "img_2": img2,
    "img_3": img3,
    "img_4": img4,
    "img_5": img5,
  };
}
