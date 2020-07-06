import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:rapidkar/classes/car.dart';
import 'package:rapidkar/classes/favorite.dart';
import 'package:rapidkar/classes/owner.dart';



Future fetchAllCar() async {
  final response = await http.get('https://www.rapidkar.com/api/public/api/car');
  return response;
}


Future fetchFavoriteOfOwner(int id) async {
  final response = await http.get('https://www.rapidkar.com/api/public/api/favorite/$id');
  return response;
}

Future logOwner(String email, String pwd) async {
  final response = await http.get('https://www.rapidkar.com/api/public/api/owner2/$email/$pwd');
  return response;
}

Future fetchCarOfOwner(int id) async {
  final response = await http.get('https://www.rapidkar.com/api/public/api/car/$id');
  return response;
}

Future updateOwner(Owner owner) async {
  //final response = await http.put('https://www.rapidkar.com/api/public/api/owner/${owner.id}');

    final response = await http.put(
    'https://www.rapidkar.com/api/public/api/owner2/${owner.id}?lastname=${owner.lastname}&firstname=${owner.firstname}&pwd=${owner.pwd}&location=${owner.location}&phone=${owner.phone}&avatar=${owner.avatar}',
    );

    return response;


}

Future createOwner(Owner owner) async {
  final response = await http.post(
      'https://www.rapidkar.com/api/public/api/owner?firstname=${owner.firstname}&lastname=${owner.lastname}&email=${owner.email}&phone=${owner.phone}&location=${owner.location}&avatar=${owner.avatar}&pwd=${owner.pwd}&isConnected=${owner.isConnected}&isMemberSince=${owner.isMemberSince}&isActivated=${owner.isActivated}&isVerified=${owner.isVerified}');

  print('sssssssssssssstttttttttttaaaaaaaaaattttttttttttttuuuuuuuuuuus ${response.statusCode}');
  return response;
}

Future createCar(Car car) async {
  final response = await http.post('https://www.rapidkar.com/api/public/api/car?brand=${car.brand}&model=${car.model}&numberplate=${car.numberplate}&gearshift=${car.gearshift}&fuel=${car.fuel}&places=${car.places}&doors=${car.doors}&lastCtrlDate=${car.lastCtrlDate}&loan=${car.loan}&insurance=${car.insurance}&driver=${car.driver}&location=Abidjan&age=${car.age}&owner=${car.owner}&tocall=${car.tocall}&available=1&img_1=${car.img1}&img_2=${car.img2}&img_3=${car.img3}&img_4=${car.img4}&img_5=${car.img5}');

  print('sssssssssssssstttttttttttaaaaaaaaaattttttttttttttuuuuuuuuuuus ${response.statusCode}');
  return response;
}

Future createFavorite(Favorite favorite) async {
  final response = await http.post('https://www.rapidkar.com/api/public/api/favorite?car=${favorite.car}&fan=${favorite.fan}');

  print('sssssssssssssstttttttttttaaaaaaaaaattttttttttttttuuuuuuuuuuus ${response.statusCode}');
  return response;
}

Future deleteFavorite(Favorite favorite) async {
  final response = await http.delete('https://www.rapidkar.com/api/public/api/favorite/${favorite.id}');

  print('sssssssssssssstttttttttttaaaaaaaaaattttttttttttttuuuuuuuuuuus ${response.statusCode}');
  return response;
}

Future deleteCar (Car car) async {
  final response = await http.delete('https://www.rapidkar.com/api/public/api/car/${car.id}');

  print('sssssssssssssstttttttttttaaaaaaaaaattttttttttttttuuuuuuuuuuus ${response.statusCode}');
  return response;
}



//Future updateOwner(Owner owner) async {
//  //final response = await http.put('https://www.rapidkar.com/api/public/api/owner/${owner.id}');
//
//  final response = await http.put(
//    'https://www.rapidkar.com/api/public/api/owner/${owner.id}?lastname=${owner.lastname}&firstname=kanga&pwd=12345678',
//  );
//
//  return response;
//
//
//}

