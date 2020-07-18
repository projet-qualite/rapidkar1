
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rapidkar/classes/car.dart';
import 'package:rapidkar/classes/favorite.dart';
import 'package:rapidkar/classes/owner.dart';
import 'package:rapidkar/data/data_http.dart';
import 'package:rapidkar/data/data_long.dart';
import 'package:rapidkar/data/data_test.dart';
import 'package:rapidkar/screens/accueil.dart';
import 'package:rapidkar/screens/dashboard.dart';
import 'package:rapidkar/screens/louer.dart';
import 'package:rapidkar/screens/louer2.dart';
import 'package:rapidkar/screens/message.dart';
import 'package:rapidkar/screens/welcome_page.dart';
import 'package:rapidkar/utils/SizeConfig.dart';

import 'ajouter.dart';

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage()
    );
  }
}




class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  int id;




  List<Widget> pages = [
    Accueil(),
    Louer2(),
    Ajouter(),
    //Message(),
    WelcomePage()
  ];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('yo la cité');

    fetchAllOwner().then((response) {
      setState(() {
        Iterable list = json.decode(response.body).reversed;
        all_owner = list.map((model) => Owner.fromJson(model)).toList();
        print(all_owner);
      });
    });


      if(currentOwner.email == '')
      {
        pages[3] = WelcomePage();

        print('yoooooooooooooooooooooooooooooooooooooooooooooooooooo ${currentOwner.email }');
      }
      else{
        pages[3] = Dashboard(owner: currentOwner,);
        print('yii ${currentOwner.email }');

      }



  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar: Container(
        height:(MediaQuery.of(context).size.height/70) *(SizeConfig.heightMultiplier) +1,
        decoration: BoxDecoration(color: Colors.orange[500], boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
            child: GNav(
                gap: 6,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.white,
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Accueil',
                  ),
                  GButton(
                    icon: LineIcons.car,
                    text: 'Louer',
                  ),
                  GButton(
                    icon: LineIcons.plus_circle,
                    text: 'Annonce',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: currentIndex,
                onTabChange: (index) {
                  setState(() {
                    currentIndex = index;
                    fetchAllCar().then((response) {
                      setState(() {
                        Iterable list = json.decode(response.body).reversed;
                        allCar = list.map((model) => Car.fromJson(model)).toList();
                        print(allCar);
                      });
                    });
                    if(currentOwner.id != -1)
                    {
                      fetchFavoriteOfOwner(currentOwner.id).then((response) {
                        setState(() {
                          Iterable list = json.decode(response.body);
                          favoritesOfOwner = list.map((model) => Favorite.fromJson(model)).toList();
                          print('ffffffffffffffffaaaaaaaaaaaaaaaav ${favoritesOfOwner[0].fan}');
                        });
                      });

                      fetchCarOfOwner(currentOwner.id).then((response) {
                        setState(() {
                          Iterable list = json.decode(response.body);
                          cars_of_owner = list.map((model) => Car.fromJson(model)).toList();
                          print(cars_of_owner);
                        });
                      });
                    }
                  });
                }),
          ),
        ),
      ),

      /*BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Accueil'),
              backgroundColor: Colors.orange[500]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              title: Text('Louer'),
              backgroundColor: Colors.orange[500]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              title: Text('Annonce'),
              backgroundColor: Colors.orange[500]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text('Messages'),
              backgroundColor: Colors.orange[500]
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profil'),
              backgroundColor: Colors.orange[500]
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index){

          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
      ),*/
    );
  }
}