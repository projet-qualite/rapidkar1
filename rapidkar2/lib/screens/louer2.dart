import 'package:flutter/material.dart';
import 'package:rapidkar/classes/car.dart';
import 'package:rapidkar/data/data_test.dart';
import 'package:rapidkar/widgets/annonce_detail.dart';
import 'package:rapidkar/widgets/home_screen.dart';


class Louer2 extends StatefulWidget {
  @override
  _Louer2 createState() => _Louer2();
}

class _Louer2 extends State<Louer2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(right: 250.0),
                  child: Container(
                    child: Image.asset('images/logo.jpg', height: 45, width: 45,)

                  ),
                ),



          Container(
            height: MediaQuery.of(context).size.height,

            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 120.0),
                  child: Text('Annonces',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0)),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.black,

                          ),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: allCar.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return _buildCarItem(allCar[index]);
                            }
                        ),)),

              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCarItem(Car car) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
//              Navigator.of(context).push(MaterialPageRoute(
//                  builder: (context) => DetailsPage(heroTag: imgPath, foodName: foodName, foodPrice: price)
//              ));

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          Hero(
                              tag: car.img1,
                              child: Image(
                                  image: NetworkImage('https://www.rapidkar.com/img/cars/${car.img1}'),
                                  fit: BoxFit.cover,
                                  height: 75.0,
                                  width: 75.0
                              )
                          ),
                          SizedBox(width: 10.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(
                                    car.brand,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                Text(
                                    car.loan.toString()+ ' FRS/JOUR',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15.0,
                                        color: Colors.orange
                                    )
                                )
                              ]
                          )
                        ]
                    )
                ),

              ],
            )
        ));
  }


}