import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rapidkar/classes/car.dart';
import 'package:rapidkar/classes/owner.dart';
import 'package:rapidkar/data/data_http.dart';
import 'package:rapidkar/data/data_test.dart';
import 'package:rapidkar/utils/SizeConfig.dart';
import 'package:rapidkar/widgets/annonce_detail.dart';
import 'package:rapidkar/widgets/home_screen.dart';
import 'package:rapidkar/widgets/modifier_profil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
              home: Dashboard(),
            );
          },
        );
      },
    );
  }
}

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.owner}) : super(key: key);

  final Owner owner;

  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {

  int nombre_de_cars = 0;
  int nombre_de_favoris = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    pr5 = new ProgressDialog(context);
    pr5.style(
        message: 'Modification en cours..',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.bounceIn,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    return Scaffold(
      backgroundColor: Color(0xffF8F8FA),
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            color: Colors.orange[500],
            height: 40 * SizeConfig.heightMultiplier,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 30.0,
                  top: 10 * SizeConfig.heightMultiplier),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 140.0),
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Deconnexion",
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize:
                                1.8 * SizeConfig.textMultiplier),
                          ),
                        ),
                        onTap: (){
                          currentOwner.email = '';
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                                (Route<dynamic> route) => false,
                          );
                        },


                      )
                  ),
                  Row(
                    children: <Widget>[

                      InkWell(

                        child: Container(
                          height: 11 * SizeConfig.heightMultiplier,
                          width: 22 * SizeConfig.widthMultiplier,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: (currentOwner.avatar == 'default.jpg' || currentOwner.avatar == null) ? AssetImage("images/profileimg.png") : NetworkImage("https://www.rapidkar.com/img/users/${currentOwner.avatar}"))),
                        ),
                        onTap: () async {
                          var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                          widget.owner.avatar = image.path.split("/").last;
                          postImageUser(image);
                          pr5.show();
                          updateOwner(widget.owner).then((response) {
                            setState(() {
                              Map<String, dynamic> list = json.decode(response.body);
                              print('ooooooooooooooooooooooooooooooooo ${response.body}');
                              currentOwner = Owner.fromJson(list);
                              currentOwner.pwd = widget.owner.pwd;

                              Future.delayed(Duration(seconds: 3)).then((value) {
                                pr5.hide().whenComplete(() {
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


                            });
                          });
                        },
                      )
                      ,
                      SizedBox(
                        width: 5 * SizeConfig.widthMultiplier,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            capitalize(widget.owner.firstname),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 3 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                                widget.owner.lastname.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 3 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                          Row(
                            children: <Widget>[],
                          )
                        ],
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 3 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            cars_of_owner.length.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 3 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Voitures",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 1.9 * SizeConfig.textMultiplier,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            favoritesOfOwner.length.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 3 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Favoris",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 1.9 * SizeConfig.textMultiplier,
                            ),
                          ),
                        ],
                      ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white60),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Modifier profil",
                                style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 1.8 * SizeConfig.textMultiplier),
                              ),
                            ),
                              onTap: (){
                                Navigator.push(this.context,
                                    MaterialPageRoute(builder: (context) {
                                      print('Marshall');
                                      return ModifierProfil(owner: currentOwner,);
                                    }));
                              },
                            )
                          ),
                          SizedBox(height: 10,),
                          ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 35 * SizeConfig.heightMultiplier),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:  EdgeInsets.only(left: 30.0, top: 3 * SizeConfig.heightMultiplier),
                      child: Text("Mes Véhicules", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 2.2 * SizeConfig.textMultiplier
                      ),),
                    ),
                    SizedBox(height: 3 * SizeConfig.heightMultiplier,),
                    Container(
                      height: 60 * SizeConfig.heightMultiplier,
                      child: (cars_of_owner.length ==0) ? Container(
                        margin: EdgeInsets.only(left: 50.0),
                        height: 20 * SizeConfig.heightMultiplier,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            _myAlbumCard2("Aucun véhicule"),
                            SizedBox(
                              width: 10 * SizeConfig.widthMultiplier,
                            ),
                          ],
                        ),
                      ) : Expanded(
                          child: SizedBox(
                              height: 200.0,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(8),
                                itemCount: cars_of_owner.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 250,
                                    child: myCars(cars_of_owner[index]),
                                  );
                                },
                                separatorBuilder: (BuildContext context,
                                    int index) => const Divider(),
                              ))),
                    ),
                    SizedBox(height: 3 * SizeConfig.heightMultiplier,),
                    Padding(
                      padding:  EdgeInsets.only(left: 30.0, top: 3 * SizeConfig.heightMultiplier),
                      child: Text("Favoris", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 2.2 * SizeConfig.textMultiplier
                      ),),
                    ),
                    SizedBox(height: 3 * SizeConfig.heightMultiplier,),
                    Container(
                      height: 60 * SizeConfig.heightMultiplier,
                      child: (favoritesOfOwner.length ==0) ?Container(
                        margin: EdgeInsets.only(left: 50.0),
                        height: 20 * SizeConfig.heightMultiplier,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            _myAlbumCard2("Aucun favoris"),
                            SizedBox(
                              width: 10 * SizeConfig.widthMultiplier,
                            ),
                          ],
                        )
                      ) : Expanded(
                          child: SizedBox(
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(8),
                                itemCount: favoritesOfOwner.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 200,
                                    child: myCars(createNew(favoritesOfOwner[index].car)),
                                  );
                                },
                                separatorBuilder: (BuildContext context,
                                    int index) => const Divider(),
                              ))),
                    ),
                    SizedBox(height: 3 * SizeConfig.heightMultiplier,)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _myAlbumCard(String asset1, String asset2, String asset3, String asset4,
      String more, String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Container(
        height: 37 * SizeConfig.heightMultiplier,
        width: 60 * SizeConfig.widthMultiplier,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey, width: 0.2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      asset1,
                      height: 27 * SizeConfig.imageSizeMultiplier,
                      width: 27 * SizeConfig.imageSizeMultiplier,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      asset2,
                      height: 27 * SizeConfig.imageSizeMultiplier,
                      width: 27 * SizeConfig.imageSizeMultiplier,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier,
              ),
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      asset3,
                      height: 27 * SizeConfig.imageSizeMultiplier,
                      width: 27 * SizeConfig.imageSizeMultiplier,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Spacer(),
                  Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          asset4,
                          height: 27 * SizeConfig.imageSizeMultiplier,
                          width: 27 * SizeConfig.imageSizeMultiplier,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        child: Container(
                          height: 27 * SizeConfig.imageSizeMultiplier,
                          width: 27 * SizeConfig.imageSizeMultiplier,
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Center(
                            child: Text(
                              more,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 2.5 * SizeConfig.textMultiplier,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 10.0, top: 2 * SizeConfig.heightMultiplier),
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 2 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _myAlbumCard2(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Container(
        height: 37 * SizeConfig.heightMultiplier,
        width: 60 * SizeConfig.widthMultiplier,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey, width: 0.2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: 10.0, top: 2 * SizeConfig.heightMultiplier),
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 2 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _favoriteCard(String s) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.asset(
          s,
          height: 20 * SizeConfig.heightMultiplier,
          width: 70 * SizeConfig.widthMultiplier,
          fit: BoxFit.cover,
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


  List<Widget> listView(List<Car> cars)
  {
    List<Widget> list;
    for(int i=0;i<cars.length;i++)
      {
        list.add(myCars(cars[i]));
      }
    return list;

  }


}
