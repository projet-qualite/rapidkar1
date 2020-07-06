

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapidkar/classes/car.dart';
import 'package:rapidkar/classes/owner.dart';
import 'package:rapidkar/data/data_http.dart';
import 'package:rapidkar/data/data_test.dart';
import 'package:rapidkar/utils/SizeConfig.dart';
import 'package:rapidkar/utils/utils.dart';
import 'package:rapidkar/widgets/annonce_detail.dart';
import 'package:rapidkar/widgets/home_screen.dart';

class Accueil extends StatefulWidget {
  Accueil({Key key}) : super(key: key);


  @override
  _Accueil createState() => _Accueil();
}

class _Accueil extends State<Accueil> {

  var li = new LinearProgressIndicator(
    backgroundColor: Colors.white,
    valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange[500]),
  );

  var _visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    Timer(Duration(seconds: 30),(){
      setState(() {
        _visible = false;
      });

    }
    );


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Container(
          child: Column(
            children: <Widget>[
              Image.asset('images/logo.jpg',
                height: 230,width: 230,),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white60),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Modifier profil", style: TextStyle(
                      color: Colors.white60,
                      fontSize: 1.8 * SizeConfig.textMultiplier
                  ),),
                ),
              ),
              Expanded(
                  child: SizedBox(
                      height: 200.0,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(8),
                        itemCount: allCar.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 250,
                            child: myCars(allCar[index]),
                          );
                        },
                        separatorBuilder: (BuildContext context,
                            int index) => const Divider(),
                      ))),

            ],
          )),


    );
  }

  Widget generateCard(Car car)
  {
    return GestureDetector(
      onTap: (){
        /*Navigator.push(this.context, MaterialPageRoute(builder: (context){
          print('Marshall');
          return AnnonceDetail(car: car,);
        }));*/
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Container(
                height: 200.0,
                width: 200.0,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new NetworkImage('https://www.rapidkar.com/img/cars/${car.img1}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                child:new Stack(
                  children: <Widget>[
                    new Positioned(
                      right: 0.0,
                      bottom: -10.0,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 150,
                          child: FlatButton(
                            onPressed: () {
                              if(currentOwner.email == '')
                                {
                                  Navigator.push(this.context, MaterialPageRoute(builder: (context){
                                    print('Marshall');
                                    currentIndex = 4;
                                    return MyHomePage();
                                  }));
                                }
                              else {
                                Navigator.push(this.context,
                                    MaterialPageRoute(builder: (context) {
                                      print('Marshall');
                                      return DetailsPage(car: car,);
                                    }));
                              }
                            },
                            child: Text(
                              "Plus d'infos",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  letterSpacing: 1.4,
                                  fontFamily: "arial"),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(35)),
                            ),
                            color: Colors.orange[500],
                            padding: EdgeInsets.all(5),
                          ),
                        ),
                      )
                    ),
                    new Positioned(
                        right: 0.0,
                        bottom: 0.0,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: AnimatedOpacity(

                            opacity: _visible ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 500),
                            child:  SizedBox(
                                width: 300,
                                child: li
                            ),
                          )

                        )
                    ),
                  ],
                )



              ),


            ),



          ],
        ),

      ),
    );
  }


  myCars(Car car) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Container(
        height: 37 * SizeConfig.heightMultiplier,
        width: 60 * SizeConfig.widthMultiplier,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey, width: 0.2)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: (car.img1 != null) ?Image.network('https://www.rapidkar.com/img/cars/${car.img1}', height: 60 * SizeConfig.imageSizeMultiplier, width: 55 * SizeConfig.imageSizeMultiplier, fit: BoxFit.cover,) : Text(''),
                  ),


              Spacer(),
              SizedBox(height: 1 * SizeConfig.heightMultiplier,),

              Padding(
                padding:  EdgeInsets.only(left: 10.0, top: 2 * SizeConfig.heightMultiplier),
                child: Container(
                  height: 100,
                  child: Stack(
                    children: <Widget>[

                      new Positioned(
                        right: 10.0,
                        top: 55.0,
                        child: SizedBox(
                          width: 70,
                          child: FlatButton(
                            onPressed: () {
                              if(currentOwner.email == '')
                              {
                                Navigator.push(this.context, MaterialPageRoute(builder: (context){
                                  print('Marshall');
                                  currentIndex = 3;
                                  return MyHomePage();
                                }));
                              }
                              else {
                                Navigator.push(this.context,
                                    MaterialPageRoute(builder: (context) {
                                      print('Marshall');
                                      return DetailsPage(car: car,);
                                    }));
                              }
                            },
                            child: Text(
                              "Plus d'infos",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 7,
                                  letterSpacing: 1.4,
                                  fontFamily: "arial"),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                            ),
                            color: Colors.orange[500],
                            padding: EdgeInsets.all(5),
                          ),
                        ),),


                      new Positioned(
                        left: 10.0,
                        child: Text(car.brand, style: TextStyle(
                          color: Colors.black,
                          fontSize: 3 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.bold
                      ),),),

                      new Positioned(
                        left: 10.0,
                        top: 25,
                        child: Text(car.loan.toString()+' FRS/JOUR', style: TextStyle(
                            color: Colors.orange,
                            fontSize: 2 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.bold
                        ),),),




                    ],
                  ),
                )




                    ),







                  ],
                )
              )

          ),


    );
  }

}
