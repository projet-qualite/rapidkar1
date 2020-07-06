import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rapidkar/classes/car.dart';
import 'package:rapidkar/classes/favorite.dart';
import 'package:rapidkar/data/data_http.dart';
import 'package:rapidkar/data/data_test.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_screen.dart';
import 'modifier_car.dart';

class DetailsPage extends StatefulWidget {
  final Car car;

  DetailsPage({this.car});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var selectedCard = 'Modèle';

  CupertinoAlertDialog dialog(){
    return CupertinoAlertDialog(
      title: Text('Voulez vous supprimer ?'),
      actions: <Widget>[
        CupertinoDialogAction(child: Text('Non'),),
        CupertinoDialogAction(child: Text('Oui'),)
      ],
    );
  }


  List<Widget> favoriteButton() {

    return [
      IconButton(icon: Icon(Icons.favorite_border,
        color: Colors.white,
      ), onPressed: () {
        setState(() {
          index = 1;
          Favorite fav = Favorite(
              id: -1,
              car: widget.car.id,
            fan: currentOwner.id
              );
          createFavorite(fav);
          fetchFavoriteOfOwner(currentOwner.id).then((response) {
            setState(() {
              Iterable list = json.decode(response.body);
              favoritesOfOwner = list.map((model) => Favorite.fromJson(model)).toList();
              print('ffffffffffffffffaaaaaaaaaaaaaaaav ${favoritesOfOwner[0].fan}');
            });
          });
        });

      },),

      IconButton(icon: Icon(Icons.favorite,
        color: Colors.white,),
        onPressed: () {
          setState(() {
            index = 0;
          });
        },)
    ];
  }

//  void _showDialog() {
//    // flutter defined function
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text("Voulez vous supprimer ?"),
//          actions: <Widget>[
//            // usually buttons at the bottom of the dialog
//            new FlatButton(
//              child: new Text("Non"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//            new FlatButton(
//              child: new Text("Oui"),
//              onPressed: () {
//                pr.show();
//                deleteCar (widget.car);
//                Future.delayed(Duration(seconds: 3)).then((value) {
//                  pr.hide().whenComplete(() {
//                    Navigator.pushAndRemoveUntil(
//                      context,
//                      MaterialPageRoute(builder: (context) {
//                        currentIndex = 3;
//                        return MyHomePage();
//                      }),
//                          (Route<dynamic> route) => false,
//                    );
//                  });
//                });
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
  var isFav;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(favorite(widget.car) != null)
      {
        index = 1;
      }
    else{
      index = 0;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr;
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Suppression en cours...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    return Scaffold(
        backgroundColor: Colors.orange[500],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Details',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  color: Colors.white)),
          actions: <Widget>[
           favoriteButton()[index],
            (widget.car.owner == currentOwner.id ) ? IconButton(
              icon: Icon(Icons.mode_edit,
                color: Colors.white,),
              onPressed: (){
                Navigator.push(this.context,
                    MaterialPageRoute(builder: (context) {
                      print('Marshall');
                      return ModifierCar(car: widget.car,);
                    }));
              },
            ) : Container(color: Colors.orange[500],),
            (widget.car.owner == currentOwner.id ) ? IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Voulez vous supprimer ?"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Non"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        new FlatButton(
                          child: new Text("Oui"),
                          onPressed: () {
                            pr.show();
                            deleteCar (widget.car);
                            Future.delayed(Duration(seconds: 3)).then((value) {
                              pr.hide().whenComplete(() {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    currentIndex = 3;
                                    return MyHomePage();
                                  }),
                                      (Route<dynamic> route) => false,
                                );
                              });
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              color: Colors.white,
            ): Container(color: Colors.orange[500],),


          ],
        ),
        body: ListView(children: [
          Stack(children: [
            Container(
                height: MediaQuery.of(context).size.height - 82.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent),
            Positioned(
                top: 75.0,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height - 100.0,
                    width: MediaQuery.of(context).size.width)),
            Positioned(
                top: 100.0,
                left: 40,
                right: 40,
                child: Hero(
                    tag: widget.car.img1,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45.0),
                            topRight: Radius.circular(45.0),
                          ),
                      ),
                        child: Carousel(
                          boxFit: BoxFit.cover,
                          borderRadius: true,
                          autoplay: false,
                          animationCurve: Curves.fastOutSlowIn,
                          animationDuration: Duration(milliseconds: 1000),
                          dotSize: 6.0,
                          dotIncreasedColor: Colors.deepOrangeAccent,
                          dotBgColor: Colors.transparent,
                          dotPosition: DotPosition.topRight,
                          dotVerticalPadding: 10.0,
                          showIndicator: true,
                          indicatorBgPadding: 7.0,
                          images: [
                            Image.network('https://www.rapidkar.com/img/cars/${widget.car.img1}',width: 100,height: 100,),
                            Image.network('https://www.rapidkar.com/img/cars/${widget.car.img2}',width: 100,height: 100),
                            Image.network('https://www.rapidkar.com/img/cars/${widget.car.img3}',width: 100,height: 100),
                            Image.network('https://www.rapidkar.com/img/cars/${widget.car.img4}',width: 100,height: 100),
                            Image.network('https://www.rapidkar.com/img/cars/${widget.car.img5}',width: 100,height: 100),

                          ],
                        ),
                        height: 140.0,
                        width: 500.0))),
            Positioned(
                top: 250.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.car.brand,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.car.loan.toString()+ ' FRS/JOUR',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20.0,
                                color: Colors.grey)),
                        Container(height: 25.0, color: Colors.grey, width: 1.0),
                        Container(
                          width: 125.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.0),
                              color: (widget.car.available == 1 ) ? Colors.green : Colors.red),
                          child: (widget.car.available == 1 ) ? Center(child: Text('Disponible',),) : Center(child: Text('Indisponible',),)
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                        height: 150.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            _buildInfoCard('Modèle', widget.car.model),
                            SizedBox(width: 10.0),
                            _buildInfoCard('Boite de vitesse', gearshift(widget.car.gearshift)),
                            SizedBox(width: 10.0),
                            _buildInfoCard('Sièges', widget.car.places.toString()),
                            SizedBox(width: 10.0),
                            _buildInfoCard('Carburant', fuel(widget.car.fuel)),
                            SizedBox(width: 10.0),
                            _buildInfoCard('Année', widget.car.age.toString())
                          ],
                        )
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.only(bottom: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0)),
                          color: Colors.black
                      ),
                      height: 50.0,
                      child: Center(
                          child: FlatButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: Text("Contact"),
                                      content: Text('${widget.car.tocall}'),
                                    );
                                  }
                              );
                            },
                            child: Text(
                                'Contacter',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat'
                                )
                            ),
                          )
                          ),
                        ),


                  ],
                ))
          ])
        ]));
  }

  Widget _buildInfoCard(String cardTitle, String info) {
    return InkWell(
        onTap: () {
          selectCard(cardTitle);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: cardTitle == selectedCard ? Colors.orange[300] : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard ?
                  Colors.transparent :
                  Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75
              ),

            ),
            height: 100.0,
            width: 100.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(cardTitle,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          color:
                          cardTitle == selectedCard ? Colors.white : Colors.grey.withOpacity(0.7),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(info,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14.0,
                                color: cardTitle == selectedCard
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold)),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Image(image: AssetImage('images/logo.jpg'), height: 60,width: 60),
                        )
                      ],
                    ),
                  )
                ]
            )
        )
    );
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }

  String fuel(String fuel)
  {
    switch(fuel)
    {
      case 'E':
        return 'Essence';
        break;
      case 'G':
        return 'Gazoil';
        break;
      case 'D':
        return 'Diesel';
        break;

    }
  }

  String gearshift(String gear)
  {
    switch(gear)
    {
      case 'A':
        return 'Automatique';
        break;
      case 'SA':
        return 'Semi-automatique';
        break;
      case 'M':
        return 'Manuel';
        break;

    }
  }
}
