
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rapidkar/classes/car.dart';
import 'package:rapidkar/classes/favorite.dart';
import 'package:rapidkar/classes/owner.dart';
import 'package:rapidkar/data/data_http.dart';



List<Car> allCar = [];
List<Favorite> favoritesOfOwner=[];
List<String> marques;
var dt = DateTime.now();
var newFormat = DateFormat("yyyy-MM-dd");
String updatedDt = newFormat.format(dt);

Owner currentOwner = Owner(
    id: -1,
    firstname:'',
    lastname:'',
    email:'',
    phone:'',
    location:'',
    avatar:'',
    pwd:'',
    isConnected:1,
    isMemberSince: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
    isActivated:1,
    isVerified:1,
    billingId:50

);

//String currentPwd = currentOwner.pwd;
List<Car> carOfUser = [];
Car currentCar = Car(
  id: -1,
  brand: '',
  model: '',
  numberplate: '',
  gearshift: '',
  fuel: '',
  places: 0,
  doors: 0,
  lastCtrlDate: DateTime.now(),
  loan: 0,
  insurance: 0,
  driver: 0,
  location: '',
  age: 0,
  owner: 0,
  tocall: '',
  available: 0,
  img1: '',
  img2: '',
  img3: '',
  img4: '',
  img5: ''
);
List<Owner> owners = [];
int currentIndex = 0;

String capitalize(String string) {
  if (string == null) {
    throw ArgumentError("string: $string");
  }

  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}

ProgressDialog pr5;
void showCenterShortToast(String texte) {
  Fluttertoast.showToast(
      msg: texte,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1);
}

void postImageCar(File image) async {
//  final response = await http.post('https://www.rapidkar.com/api/public/api/file/country_list?photo',
//      body: {
//        'photo': image
//      });
//  print('sssssssssssssstttttttttttaaaaaaaaaattttttttttttttuuuuuuuuuuus ${response.statusCode}');
  var dio = Dio();
  FormData formData = new FormData.fromMap({
    "photo": await MultipartFile.fromFile('${image.path}',filename: '${image.path.split("/").last}'),
  });
  var response = await dio.post("https://www.rapidkar.com/api/public/api/file/country_list", data: formData);
  print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa $response');
}

void postImageUser(File image) async {
//  final response = await http.post('https://www.rapidkar.com/api/public/api/file/country_list?photo',
//      body: {
//        'photo': image
//      });
//  print('sssssssssssssstttttttttttaaaaaaaaaattttttttttttttuuuuuuuuuuus ${response.statusCode}');
  var dio = Dio();
  FormData formData = new FormData.fromMap({
    "photo": await MultipartFile.fromFile('${image.path}',filename: '${image.path.split("/").last}'),
  });
  var response = await dio.post("https://www.rapidkar.com/api/public/api/file/user_list", data: formData);
  print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa $response');
}

Car createNew(int car)
{
  for(int i=0;i<allCar.length;++i)
    {
      if(allCar[i].id == car)
        {
          return allCar[i];
        }
    }
}

Favorite favorite(Car car)
{
  var fav;
  for(int i=0;i<favoritesOfOwner.length;++i)
  {
    if(favoritesOfOwner[i].car == car.id)
    {
      fav = favoritesOfOwner[i];
      return fav;
    }
  }
  return null;

}
var index;
List<Car> cars_of_owner = [];