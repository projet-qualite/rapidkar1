


import 'dart:convert';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rapidkar/classes/car.dart';
import 'package:rapidkar/data/data_http.dart';
import 'package:rapidkar/data/data_test.dart';
import 'package:rapidkar/widgets/first_page.dart';

import 'home_screen.dart';


class ModifierCar extends StatefulWidget {
  ModifierCar({Key key, this.car}) : super(key: key);

  final Car car;

  @override
  _ModifierCar createState() => _ModifierCar();
}

class _ModifierCar extends State<ModifierCar> {

  Widget _annonces(BuildContext context)
  {
    return ListTile(

      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(
                'yo la cité'
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffddddff),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
                'yo'
            ),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: MarqueModele(car: widget.car,)
    );



  }
}



List<String> marque = <String>[
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
  'Toyota'
];





class MarqueModele extends StatefulWidget {
  MarqueModele({this.car});

  final Car car;


  @override
  _MarqueModele createState() => _MarqueModele();
}

class _MarqueModele extends State<MarqueModele> {

  String dropdownValue = 'Audi';

  final List<Tab> tab= <Tab>[Tab(text: 'Information',), Tab(text: 'Compte',)];


  var selectedMarque2;

  TextEditingController _controllerModele = TextEditingController();


  @override
  Widget build(BuildContext context) {

    _controllerModele.text = widget.car.model;

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: Image.asset('images/logo.jpg'),
        backgroundColor: Colors.orange[700],
        title: Text('Modifier votre annonce'),
      ),
      body: Center(
          child: SingleChildScrollView(
              child: Container(
                  child:Column(
                    children: <Widget>[
                      Text('Quel est la marque de votre véhicule ?',
                        style: TextStyle(fontSize: 20.0),),
                      DropdownButton(
                        items: marque.map((value) => DropdownMenuItem(
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.deepOrangeAccent),
                          ),

                          value: value,
                        )).toList(),
                        onChanged: (selectedMarque){
                          setState(() {
                            selectedMarque2 = selectedMarque;
                            currentCar.brand = selectedMarque2;
                          });
                        },
                        value: selectedMarque2,
                        hint: Text(widget.car.brand,
                          style: TextStyle(color: Colors.deepOrangeAccent),),

                      ),

                      SizedBox(height: 40.0,),
                      Text('Quel est le modèle de votre véhicule ?',
                        style: TextStyle(fontSize: 20.0),),
                      Container(
                        margin: EdgeInsets.only(top: 10.0,right: 40.0,left: 40.0),
                        child: Column(
                          children: <Widget>[

                            TextField(
                              controller: _controllerModele,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.directions_car),
                                  labelText: 'Modèle'
                              ),
                            ),
                            SizedBox(height: 80.0,),

                            InkWell(
                                onTap: () {

                                  /*if(mainOwner.id == -1)
                              {
                                Fluttertoast.showToast(msg: "Vous n'êtes pas inscrit",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    textColor: Colors.deepOrangeAccent,
                                    fontSize: 16.0);
                              }*/
                                  if (currentOwner.email == '') {
                                    showCenterShortToast(
                                        'Veuillez vous inscrire ou vous connecter');
                                  }
                                  else {
                                    if (_controllerModele.text.isEmpty) {
                                      showCenterShortToast(
                                          'Modele non valide');
                                    }

                                    else {
                                      currentCar.model =
                                          _controllerModele.text;

                                      Navigator.push(this.context,
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) {
                                                return Immatriculation(
                                                    car: widget.car);
                                              }));
                                    }
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(vertical: 15),

                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          offset: Offset(2, 4),
                                          blurRadius: 5,
                                          spreadRadius: 2,)
                                      ],
                                      color: Colors.orange[500]
                                  ),
                                  child: Text(
                                    'Continuer',
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                )),
                          ],
                        ),


                      )],
                  ))

          )),

    );
  }


}









class Immatriculation extends StatefulWidget {
  Immatriculation({this.car});
  final Car car;

  @override
  _Immatriculation createState() => _Immatriculation();
}

class _Immatriculation extends State<Immatriculation> {


  TextEditingController _controllerImm = TextEditingController();

  TextEditingController _controllerPlace = TextEditingController();
  TextEditingController _controllerSiege = TextEditingController();
  TextEditingController _controllerPortiere = TextEditingController();


  @override
  Widget build(BuildContext context) {

    _controllerPlace.text = widget.car.places.toString();
    _controllerPortiere.text = widget.car.doors.toString();
    _controllerImm.text = widget.car.numberplate;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: Text('Modifier votre annonce'),
      ),
      body: Center(
          child: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(top: 60.0),
                child:Column(
                  children: <Widget>[

                    SizedBox(height: 1.0,),
                    Container(
                      margin: EdgeInsets.only(top: 10.0,right: 40.0,left: 40.0),
                      child: Column(
                        children: <Widget>[
                          Text('Quel est l\'immatriculation de votre véhicule ?',
                            style: TextStyle(fontSize: 20.0),),
                          TextField(
                            controller: _controllerImm,
                            decoration: InputDecoration(
                                icon: Icon(Icons.sd_card),
                                labelText: 'Immatriculation'
                            ),
                          ),
                          SizedBox(height: 50.0,),
                          TextField(
                            keyboardType: TextInputType.numberWithOptions(signed:false, decimal: false),
                            controller: _controllerPortiere,
                            decoration: InputDecoration(
                                icon: Icon(Icons.phone),
                                labelText: 'Nombre de portières'
                            ),
                          ),
                          SizedBox(height: 50.0,),
                          TextField(
                            keyboardType: TextInputType.numberWithOptions(signed:false, decimal: false),
                            controller: _controllerPlace,
                            decoration: InputDecoration(
                                icon: Icon(Icons.airline_seat_recline_extra),
                                labelText: 'Nombre de sièges'
                            ),
                          ),

                          SizedBox(height: 50.0,),




                          InkWell(
                              onTap: (){
                                if(_controllerImm.text.isEmpty)
                                {
                                  showCenterShortToast("Immatriculation non valide");
                                }
                                else{
                                  if(int.tryParse(_controllerPlace.text) == 0 || _controllerPlace.text.isEmpty)
                                  {
                                    showCenterShortToast("Nombre de siège non valide.");
                                  }
                                  else{
                                    if(int.tryParse(_controllerPortiere.text) == 0 || _controllerPortiere.text.isEmpty)
                                    {
                                      showCenterShortToast("Nombre de portière non valide.");
                                    }
                                    else{
                                      currentCar.numberplate = _controllerImm.text;
                                      currentCar.places = int.tryParse(_controllerPlace.text);
                                      currentCar.doors = int.tryParse(_controllerPortiere.text);

                                      Navigator.push(this.context,
                                          MaterialPageRoute<void>(
                                              builder:(BuildContext context) {
                                                return Detail(car: widget.car);
                                              }));
                                    }
                                  }
                                }


                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(vertical: 15),

                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        offset: Offset(2, 4),
                                        blurRadius: 5,
                                        spreadRadius: 2,)
                                    ],
                                    color: Colors.orange[500]
                                ),
                                child: Text(
                                  'Continuer',
                                  style: TextStyle(fontSize: 20, color: Colors.white),
                                ),
                              )),
                        ],
                      ),


                    )],
                )),
          )),

      resizeToAvoidBottomPadding: false,
    );
  }


}



class Detail extends StatefulWidget {
  Detail({this.car});

  final Car car;


  @override
  _Detail createState() => _Detail();
}

class _Detail extends State<Detail> {

  var selectedMarque;

  List<String> chauffeur = <String>[
    'Oui',
    'Non'
  ];

  List<String> essence = <String>[
    'Essence',
    'Gazoil',
    'Diesel',
  ];

  List<String> boite = <String>[
    'Automatique',
    'Semi-automatique',
    'Manuel',
  ];

  List<String> assurance = <String>[
    'Oui',
    'Non'
  ];

  var selectedAssurance;
  var selectedChauffer2;
  var selectedEssence;
  var selectedBoite;
  TextEditingController _controllerMontant = TextEditingController();
  TextEditingController _controllerContact = TextEditingController();
  TextEditingController _controllerDateCT = TextEditingController();
  TextEditingController _controllerDate = TextEditingController();

  DateTime dateCT;


  String fuel(String fuel)
  {
    switch(fuel)
    {
      case 'Essence':
        return 'E';
        break;
      case 'Gazoil':
        return 'G';
        break;
      case 'Diesel':
        return 'D';
        break;

    }
  }

  String gearshift(String gear)
  {
    switch(gear)
    {
      case 'Automatique':
        return 'A';
        break;
      case 'Semi-automatique':
        return 'SA';
        break;
      case 'Manuel':
        return 'M';
        break;

    }
  }

  String fuel2(String fuel)
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

  String gearshift2(String gear)
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

  String Ass(int ass)
  {
    switch(ass)
    {
      case 0:
        return 'Non';
        break;
      case 1:
        return 'Oui';
        break;

    }
  }





  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final dateFormat = DateFormat("yyyy-MM-dd");

    var currentDateCT;

    _controllerMontant.text = widget.car.loan.toString();
    _controllerDate.text = widget.car.age.toString();
    _controllerDateCT.text = widget.car.lastCtrlDate.toString();
    _controllerContact.text = widget.car.tocall.toString();
    selectedEssence = fuel2(widget.car.fuel);
    selectedBoite = gearshift2(widget.car.gearshift);
    selectedAssurance = Ass(widget.car.insurance);
    selectedChauffer2 = Ass(widget.car.driver);



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: Text('Poster une annonce'),
      ),
      body: Center(
          child: Container(
              margin: EdgeInsets.only(top: 10.0),
              child:Column(
                children: <Widget>[

                  Text('Détails',
                    style: TextStyle(fontSize: 40.0),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,right: 40.0,left: 40.0),
                    child: Column(
                      children: <Widget>[

                        DropdownButton(
                          items: essence.map((value) => DropdownMenuItem(
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.deepOrangeAccent),
                            ),

                            value: value,
                          )).toList(),
                          onChanged: (selectedE){
                            setState(() {
                              selectedEssence = selectedE;
                            });
                          },
                          value: selectedEssence,
                          hint: Text('Carburant',
                            style: TextStyle(color: Colors.deepOrangeAccent),),

                        ),

                        DropdownButton(
                          items: boite.map((value) => DropdownMenuItem(
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.deepOrangeAccent),
                            ),

                            value: value,
                          )).toList(),
                          onChanged: (selectedBo){
                            setState(() {
                              selectedBoite = selectedBo;

                            });
                          },
                          value: selectedBoite,
                          hint: Text('Boîte de vitesse',
                            style: TextStyle(color: Colors.deepOrangeAccent),),

                        ),
                        DropdownButton(

                          items: assurance.map((value) => DropdownMenuItem(
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.deepOrangeAccent),
                            ),

                            value: value,
                          )).toList(),
                          onChanged: (selectedAss){
                            setState(() {
                              selectedAssurance = selectedAss;
                            });
                          },
                          value: selectedAssurance,
                          hint: Text('Avec assurance ?',
                            style: TextStyle(color: Colors.deepOrangeAccent),),

                        ),

                        DropdownButton(
                          items: assurance.map((value) => DropdownMenuItem(
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.deepOrangeAccent),
                            ),

                            value: value,
                          )).toList(),
                          onChanged: (selectedC){
                            setState(() {
                              selectedChauffer2 = selectedC;
                            });
                          },
                          value: selectedChauffer2,
                          hint: Text('Avec chauffeur ?',
                            style: TextStyle(color: Colors.deepOrangeAccent),),

                        ),

                        TextField(
                          keyboardType: TextInputType.numberWithOptions(signed:false, decimal: false),
                          controller: _controllerMontant,
                          decoration: InputDecoration(
                              icon: Icon(Icons.monetization_on),
                              labelText: 'Montant/jour'
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.numberWithOptions(signed:false, decimal: false),
                          controller: _controllerDate,
                          decoration: InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              labelText: 'Année'
                          ),
                        ),

                        TextField(
                          keyboardType: TextInputType.numberWithOptions(signed:false, decimal: false),
                          controller: _controllerContact,
                          decoration: InputDecoration(
                              icon: Icon(Icons.phone),
                              labelText: 'Contact'
                          ),
                        ),
                        FlatButton(
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(1980, 1, 1),
                                  maxTime: DateTime.now(),
                                  theme: DatePickerTheme(
                                      headerColor: Colors.orange[600],
                                      backgroundColor: Colors.orange[500],
                                      itemStyle: TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                      doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
                                  onChanged: (date) {
                                    currentDateCT = date;
                                    print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee $date');
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                  }, currentTime: widget.car.lastCtrlDate, locale: LocaleType.fr);
                            },
                            child: Text(
                              'Date dernier contrôle technique',
                              style: TextStyle(color: Colors.blue),
                            )),

                        SizedBox(height: 40.0,),

                        InkWell(
                            onTap: (){

                              if(selectedChauffer2 == null)
                              {
                                showCenterShortToast("Selectionner avec ou sans chauffeur.");
                              }
                              else{
                                if(selectedAssurance == null)
                                {
                                  showCenterShortToast("Selectionner avec ou sans assurance.");
                                }

                                else{

                                  if(_controllerContact.text.isEmpty || int.tryParse(_controllerContact.text)==0)
                                  {
                                    showCenterShortToast("Contact non valide.");
                                  }
                                  else{
                                    if(_controllerDate.text.isEmpty || int.tryParse(_controllerDate.text)>2020 || int.tryParse(_controllerDate.text)<1900)
                                    {
                                      showCenterShortToast("Année non valide.");
                                    }
                                    else{
                                      if(_controllerMontant.text.isEmpty || int.tryParse(_controllerMontant.text)<=0)
                                      {
                                        showCenterShortToast("Montant non valide.");
                                      }

                                      else{
                                        currentCar.driver = (selectedChauffer2 == 'Oui') ? 1:0;
                                        currentCar.insurance = (selectedAssurance == 'Oui') ? 1:0;
                                        currentCar.loan = int.tryParse(_controllerMontant.text);
                                        currentCar.age = int.tryParse(_controllerDate.text);
                                        currentCar.tocall = _controllerContact.text;
                                        currentCar.owner = currentOwner.id;
                                        if(selectedBoite==null)
                                        {
                                          showCenterShortToast("Selectionner boîte de vitesse.");
                                        }
                                        else{
                                          if(selectedEssence==null)
                                          {
                                            showCenterShortToast("Selectionner type de carburant.");
                                          }
                                          else {

                                              currentCar.gearshift = gearshift(
                                                  selectedBoite.toString());
                                              currentCar.fuel = fuel(
                                                  selectedEssence.toString());
                                              currentCar.lastCtrlDate = currentDateCT;


                                              Navigator.push(this.context,
                                                  MaterialPageRoute<void>(
                                                      builder: (
                                                          BuildContext context) {
                                                        return ImageFile(car: widget.car);
                                                      }));

                                          }
                                        }


                                      }
                                    }
                                  }

                                }
                              }






                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 15),

                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: Offset(2, 4),
                                      blurRadius: 5,
                                      spreadRadius: 2,)
                                  ],
                                  color: Colors.orange[500]
                              ),
                              child: Text(
                                'Continuer',
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            )),
                      ],
                    ),


                  )],
              ))),

      resizeToAvoidBottomPadding: false,
    );
  }


}


class ImageFile extends StatefulWidget {

  ImageFile({this.car});
  final Car car;

  @override
  _ImageFile createState() => _ImageFile();
}

class _ImageFile extends State<ImageFile> {


  TextEditingController _controllerImm = TextEditingController();
  dynamic _image1;
  File _image2;
  File _image3;
  File _image4;
  File _image5;

  int index1=0;
  int index2=0;
  int index3=0;
  int index4=0;
  int index5=0;







@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('${widget.car.img1} ${widget.car.img2} ${widget.car.img5}');
  }
  @override
  Widget build(BuildContext context) {

    var img1 = [Image.network('https://www.rapidkar.com/img/cars/${widget.car.img1}',fit: BoxFit.cover,)];
    var img2 = [Image.network('https://www.rapidkar.com/img/cars/${widget.car.img2}',fit: BoxFit.cover,), 4];
    var img3 = [Image.network('https://www.rapidkar.com/img/cars/${widget.car.img3}',fit: BoxFit.cover,), 4];
    var img4 = [Image.network('https://www.rapidkar.com/img/cars/${widget.car.img4}',fit: BoxFit.cover,), 4];
    var img5 = [Image.network('https://www.rapidkar.com/img/cars/${widget.car.img5}',fit: BoxFit.cover,), 4];


    ProgressDialog pr = new ProgressDialog(context);
    pr.style(
        message: 'Veuillez Patienter...',
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
        appBar: AppBar(
          backgroundColor: Colors.orange[500],
          title: Text('Images'),
        ),

        body: Column(
          children: <Widget>[
            GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      _image1 = image;
                      img1 = [Image.file(_image1, fit: BoxFit.cover,)];
                      print(img1);
                      index1 = 1;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ImageFile(car: widget.car,);
                        }),
                            (Route<dynamic> route) => false,
                      );
                    });
                  },
                  child: Container(
                    color: Colors.black12,
                    child: widget.car.img1 == null ? Icon(Icons.add): img1[0],
                  ),
                ),
                GestureDetector(
                  onTap: getImage2,
                  child: Container(
                    color: Colors.black12,
                    child: _image2 == null ? Icon(Icons.add): Image.file(_image2, fit: BoxFit.cover,),
                  ),
                ),
                GestureDetector(
                  onTap: getImage3,
                  child: Container(
                    color: Colors.black12,
                    child: _image3 == null ? Icon(Icons.add): Image.file(_image3, fit: BoxFit.cover,),
                  ),
                ),
                GestureDetector(
                  onTap: getImage4,
                  child: Container(
                    color: Colors.black12,
                    child: _image4 == null ? Icon(Icons.add): Image.file(_image4, fit: BoxFit.cover,),
                  ),
                ),
                GestureDetector(
                  onTap: getImage5,
                  child: Container(
                    color: Colors.black12,
                    child: _image5 == null ? Icon(Icons.add): Image.file(_image5, fit: BoxFit.cover,),
                  ),
                )
              ],

            ),

            InkWell(
                onTap: () async{

                  print('cccccuuuuuuuuuuurrrrrrrreeeeeeeeennnnnnnnnttttttt ${_image1.path.split("/").last} ');





                  if(_image1!=null)
                  {
                    currentCar.img1 = _image1.path.split("/").last;
                    postImageCar(_image1);
                  }
                  if(_image2!=null)
                  {
                    currentCar.img2 = _image2.path.split("/").last;
                    postImageCar(_image2);
                  }
                  if(_image3!=null)
                  {
                    currentCar.img3 = _image3.path.split("/").last;
                    postImageCar(_image3);
                  }
                  if(_image4!=null)
                  {
                    currentCar.img4 = _image4.path.split("/").last;
                    postImageCar(_image4);
                  }
                  if(_image5!=null)
                  {
                    currentCar.img5 = _image5.path.split("/").last;
                    postImageCar(_image5);
                  }

                  /*currentCar.img1 = (_image1.path) == null ? '': _image1.path;
                  currentCar.img2 = (_image2.path) == null ? '': _image2.path;
                  currentCar.img3 = (_image3.path) == null ? '': _image3.path;
                  currentCar.img4 = (_image4.path) == null ? '': _image4.path;
                  currentCar.img5 = (_image5.path) == null ? '': _image5.path;

                  currentCar.owner = mainOwner.id;


                  pr.show();


                  final Car o = await createCar(currentCar);

                  Future.delayed(Duration(seconds: 3)).then((value) {
                    pr.hide().whenComplete(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            currentIndex = 4;
                            return new MyHomePage();
                          }));
                    });
                  });

*/

                  /*print('cccccuuuuuuuuuuurrrrrrrreeeeeeeeennnnnnnnnttttttt ${currentCar.available}| ${currentCar.driver} |${currentCar.loan} |${currentCar.places} ');
                  print('cccccuuuuuuuuuuurrrrrrrreeeeeeeeennnnnnnnnttttttt ${currentCar.gearshift}| ${currentCar.lastCtrlDate} ');*/
                  pr.show();
                  createCar(currentCar).then((response) {
                    setState(() {
                      //Map<String, dynamic> list = json.decode(response.body);
                      FirstPage();
                      print('ooooooooooooooooooooooooooooooooo ${response.body}');
                      Future.delayed(Duration(seconds: 3)).then((value) {
                        pr.hide().whenComplete(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                                currentIndex = 3;
                                return new MyHomePage();
                              }));
                        });
                      });


                    });
                  });





                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15),

                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 40,right: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(2, 4),
                          blurRadius: 5,
                          spreadRadius: 2,)
                      ],
                      color: Colors.orange[500]
                  ),
                  child: Text(
                    'Continuer',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),

          ],
        )

    );
  }



  Future getImage1() async
  {


  }
  Future getImage2() async
  {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image2 = image;
      index2 = 1;
    });

    print('Imageeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee : $image');
  }Future getImage3() async
  {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image3 = image;
      index3 = 1;
    });

    print('Imageeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee : $image');
  }
  Future getImage4() async
  {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image4 = image;
      index5 = 1;
    });

    print('Imageeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee : $image');
  }
  Future getImage5() async
  {
    var image5 = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image5 = image5;
      index5 = 1;
    });

    print('Imageeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee : $image5');
  }








}

