import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rapidkar/classes/car.dart';
import 'package:rapidkar/data/data_http.dart';
import 'package:rapidkar/data/data_test.dart';
import 'package:rapidkar/utils/SizeConfig.dart';

import 'home_screen.dart';

class MyAppFirst extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'HomeScreen App',
              home: FirstPage(),
            );
          },
        );
      },
    );
  }
}


class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);


  @override
  _FirstPage createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    fetchAllCar().then((response) {
      setState(() {
        Iterable list = json.decode(response.body).reversed;
        allCar = list.map((model) => Car.fromJson(model)).toList();
        print(allCar);
      });
    });
    Timer(Duration(seconds: 3),() => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyApp2()),
          (Route<dynamic> route) => false,
    ));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.orange[500],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/cover.jpg',height: 300.0,width: 300.0,)

              ],
            ),
          )
      ),
    );
  }
}
