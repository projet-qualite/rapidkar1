// To parse this JSON data, do
//
//     final owner = ownerFromJson(jsonString);

import 'dart:convert';

Owner ownerFromJson(String str) => Owner.fromJson(json.decode(str));

String ownerToJson(Owner data) => json.encode(data.toJson());

class Owner {
  Owner({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.location,
    this.avatar,
    this.pwd,
    this.isConnected,
    this.isMemberSince,
    this.isActivated,
    this.isVerified,
    this.billingId,
  });

  int id;
  String firstname;
  String lastname;
  String email;
  String phone;
  String location;
  String avatar;
  String pwd;
  int isConnected;
  DateTime isMemberSince;
  int isActivated;
  int isVerified;
  dynamic billingId;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    location: json["location"],
    avatar: json["avatar"],
    pwd: json["pwd"],
    isConnected: json["isConnected"],
    isMemberSince: DateTime.parse(json["isMemberSince"]),
    isActivated: json["isActivated"],
    isVerified: json["isVerified"],
    billingId: json["billingID"],
  );

  factory Owner.fromJson2(Map<String, dynamic> json) => Owner(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    location: json["location"],
    avatar: json["avatar"],
    pwd: json["pwd"],
    isConnected: int.parse(json["isConnected"]),
    isMemberSince: DateTime.parse(json["isMemberSince"]),
    isActivated: int.parse(json["isActivated"]),
    isVerified: int.parse(json["isVerified"]),
    billingId: json["billingID"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "location": location,
    "avatar": avatar,
    "pwd": pwd,
    "isConnected": isConnected,
    "isMemberSince": "${isMemberSince.year.toString().padLeft(4, '0')}-${isMemberSince.month.toString().padLeft(2, '0')}-${isMemberSince.day.toString().padLeft(2, '0')}",
    "isActivated": isActivated,
    "isVerified": isVerified,
    "billingID": billingId,
  };
}
