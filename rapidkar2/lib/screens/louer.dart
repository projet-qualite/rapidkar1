import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapidkar/classes/car.dart';
import 'package:rapidkar/data/data_test.dart';
import 'package:rapidkar/widgets/annonce_detail.dart';

/*List<Car> cars = [
  Car(
      id: 1,
      brand: "Aston Martins",
      model: "4x4",
      numberplate: "2741GA01",
      gearshift: "M",
      fuel: "E",
      places: 4,
      doors: 4,
      lastCtrlDate: DateTime.now(),
      loan: 35000,
      insurance: 1,
      driver: 1,
      location: "Abidjan",
      age: 2014,
      owner: 1,
      tocall: "+3375814102",
      available: 0,
      img1: "images/aston1.jpg",
      img2: "images/aston2.jpg",
      img3: "images/aston3.jpg",
      img4: "images/aston2.jpg",
      img5: "images/aston3.jpg"
  ),

  Car(
      id: 2,
      brand: "Audi",
      model: "A8",
      numberplate: "2741GA01",
      gearshift: "M",
      fuel: "E",
      places: 4,
      doors: 4,
      lastCtrlDate: DateTime.now(),
      loan: 75000,
      insurance: 0,
      driver: 1,
      location: "Bouaké",
      age: 2016,
      owner: 2,
      tocall: "+22541029296",
      available: 1,
      img1: "images/audi1.jpg",
      img2: "images/audi2.jpg",
      img3: "images/audi3.jpg",
      img4: "images/audi4.jpg",
      img5: "images/audi3.jpg"
  ),

  Car(
      id: 2,
      brand: "Cadillac",
      model: "SUV",
      numberplate: "2741GA01",
      gearshift: "A",
      fuel: "G",
      places: 4,
      doors: 4,
      lastCtrlDate: DateTime.now(),
      loan: 95000,
      insurance: 1,
      driver: 1,
      location: "Bouaké",
      age: 2016,
      owner: 2,
      tocall: "+22541029296",
      available: 1,
      img1: "images/cadillac1.jpg",
      img2: "images/cadillac2.jpg",
      img3: "images/cadillac3.jpg",
      img4: "images/cadillac2.jpg",
      img5: "images/cadillac3.jpg"
  ),

  Car(
      id: 3,
      brand: "Mercedes",
      model: "Benz",
      numberplate: "2741GA01",
      gearshift: "M",
      fuel: "E",
      places: 5,
      doors: 4,
      lastCtrlDate: DateTime.now(),
      loan: 100000,
      insurance: -1,
      driver: -1,
      location: "",
      age: 2018,
      owner: 3,
      tocall: "",
      available: -1,
      img1: "images/mercedes1.jpg",
      img2: "images/mercedes2.jpg",
      img3: "images/mercedes3.jpg",
      img4: "images/mercedes2.jpg",
      img5: "images/mercedes3.jpg"
  ),

  Car(
      id: 5,
      brand: "Peugeot",
      model: "407",
      numberplate: "2741GA01",
      gearshift: "M",
      fuel: "E",
      places: 0,
      doors: 0,
      lastCtrlDate: DateTime.now(),
      loan: 60000,
      insurance: 1,
      driver: 0,
      location: "Yopougon",
      age: 2005,
      owner: 6,
      tocall: "+22503698715",
      available: 1,
      img1: "images/peugeot11.jpg",
      img2: "images/peugeot12.jpg",
      img3: "images/peugeot13.jpg",
      img4: "images/peugeot14.jpg",
      img5: "images/peugeot13.jpg"
  ),

  Car(
      id: 7,
      brand: "Peugeot",
      model: "308",
      numberplate: "2741GA01",
      gearshift: "M",
      fuel: "E",
      places: 4,
      doors: 4,
      lastCtrlDate: DateTime.now(),
      loan: 25000,
      insurance: 1,
      driver: 1,
      location: "Abidjan",
      age: 2016,
      owner: 71,
      tocall: "+22587459678",
      available: 1,
      img1: "images/peugeot1.jpg",
      img2: "images/peugeot2.jpg",
      img3: "images/peugeot1.jpg",
      img4: "images/peugeot2.jpg",
      img5: "images/peugeot1.jpg"
  ),

  Car(
      id: 8,
      brand: "Tesla",
      model: "Modele S",
      numberplate: "2741GA01",
      gearshift: "A",
      fuel: "e",
      places: 4,
      doors: 4,
      lastCtrlDate: DateTime.now(),
      loan: 150000,
      insurance: 1,
      driver: 1,
      location: "Yamoussoukro",
      age: 2017,
      owner: 41,
      tocall: "+22574123698",
      available: 1,
      img1: "images/tesla.jpg",
      img2: "images/tesla2.jpg",
      img3: "images/tesla1.jpg",
      img4: "images/tesla2.jpg",
      img5: "images/tesla1.jpg"
  ),

];*/

List<String> marque = <String>[
  'Toutes les marques',
  'Audi',
  'Bmw',
  'Citroën',
  'Fiat',
  'Ford',
  'Kia',
  'Maserati',
  'Mercedes',
  'Nissan',
  'Peugeot',
  'Toyota',
  'Volkswagen',
];

List<Car> carrs;

class Louer extends StatefulWidget {
  Louer({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Louer createState() => _Louer();
}

class _Louer extends State<Louer> {
  var selectedMarque2;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    carrs = allCar;

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              backgroundColor: Colors.orange[500],
              title: Text('Louer'),
              actions: <Widget>[
                Icon(Icons.map)
              ],
            ),
        body: Container(
          child: Column(
            children: <Widget>[
              DropdownButton(
                items: marque.map((value) => DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.deepOrangeAccent),
                  ),

                  value: value,
                )).toList(),
                onChanged: (selectedE){
                  setState(() {
                    carrs = [];
                    selectedMarque2 = selectedE;
                    for(int i=0;i<allCar.length;i++)
                      {
                        if(allCar[i].brand == selectedMarque2)
                          {
                            carrs.add(allCar[i]);
                          }
                      }
                    if(selectedMarque2 == 'Toutes les marques')
                      {
                        carrs = allCar;
                      }
                  });
                },
                value: selectedMarque2,
                hint: Text('Selectionnez la marque',
                  style: TextStyle(color: Colors.deepOrangeAccent),),

              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: allCar.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return _buildCarItem(allCar[index]);
                    }
                ),
              )
            ],
          )
        )


    );
  }

  Widget listView(Car car)
  {
    return GestureDetector(
      child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(

            child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Image.network('https://www.rapidkar.com/img/cars/${car.img1}',
                        fit: BoxFit.cover,
                      ),
                    )
                ),
                title: Text(
                  car.brand,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: <Widget>[
                    Text('${car.loan} FR/JOUR', style: TextStyle(color: Colors.lightBlue))
                  ],
                ),
                trailing:
                Icon(
                    Icons.keyboard_arrow_right, color: Colors.lightBlue, size: 30.0)),
          )

      ),

      onTap: (){
        /*Navigator.push(this.context, MaterialPageRoute(builder: (context){
          print('Marshall');
          return AnnonceDetail(car: car,);
        }));*/
      },
    );
  }


  Widget _buildCarItem(Car car) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage(car: car)
              ));
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
                                  image: AssetImage(car.img1),
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
                                    car.loan.toString(),
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15.0,
                                        color: Colors.grey
                                    )
                                )
                              ]
                          )
                        ]
                    )
                ),
                IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.black,
                    onPressed: () {}
                )
              ],
            )
        ));
  }
}