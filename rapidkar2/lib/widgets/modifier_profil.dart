import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rapidkar/classes/car.dart';
import 'package:rapidkar/classes/owner.dart';
import 'package:rapidkar/data/data_http.dart';
import 'package:rapidkar/data/data_test.dart';
import 'package:rapidkar/utils/SizeConfig.dart';
import 'package:rapidkar/widgets/modifier_mot_de_passe.dart';

import 'home_screen.dart';


class ModifierProfil extends StatefulWidget {
  ModifierProfil({Key key,this.owner}) : super(key: key);
  final Owner owner;

  @override
  _ModifierProfil createState() => _ModifierProfil();
}

class _ModifierProfil extends State<ModifierProfil> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerMDP = TextEditingController();
  TextEditingController _controllerNewMDP = TextEditingController();
  TextEditingController _controllerConfirmNewMDP = TextEditingController();
  TextEditingController _controllerNom = TextEditingController();
  TextEditingController _controllerPrenom = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerLocation = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _controllerEmail.text = widget.owner.email;
    _controllerNom.text = widget.owner.lastname;
    _controllerPrenom.text = widget.owner.firstname;
    _controllerPhone.text = widget.owner.phone;
    _controllerLocation.text = widget.owner.location;
    _controllerMDP.text = widget.owner.pwd;

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
      appBar: AppBar(
        title: Text('Modifier le profil'),
        backgroundColor: Colors.orange[500],
      ),
      body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(50),
      child: Column(
          children: <Widget>[

            InkWell(
              onTap: (){
                Navigator.push(this.context,
                    MaterialPageRoute(builder: (context) {
                      print('Marshall');
                      return ModifierMDP(owner: currentOwner,);
                    }));
              },
                child: Container(
                  margin: EdgeInsets.only(left: 150.0) ,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15),

                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.orange[500]
                  ),
                  child: Text(
                    'Modifier mot de passe',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                )),

            _entryField('Nom',_controllerNom),
            _entryField('Prenom',_controllerPrenom),
            _entryField('Email',_controllerEmail,isEnable: true),
            _entryField('Phone',_controllerPhone),
            _entryField('Localisation',_controllerLocation),



            InkWell(
                onTap: (){


                        pr5.show();
                        widget.owner.phone = _controllerPhone.text;
                        widget.owner.firstname = _controllerPrenom.text;
                        widget.owner.lastname = _controllerNom.text;
                        widget.owner.location = _controllerLocation.text;


                        updateOwner(widget.owner).then((response) {
                          setState(() {
                            Map<String, dynamic> list = json.decode(response.body);
                            print('ooooooooooooooooooooooooooooooooo $list');
                             currentOwner = Owner.fromJson(list);




                            //currentOwner = owners.first;
                            Future.delayed(Duration(seconds: 3)).then((value) {
                              pr5.hide().whenComplete(() {
                                Navigator.push(this.context,
                                    MaterialPageRoute(builder: (context) {
                                      currentIndex = 3;
                                      return MyHomePage();
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
      ]),
    )) );
  }

  Widget _entryField(String title,TextEditingController controller, {bool isPassword = false ,bool isEnable = true}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            enabled: isEnable,
              obscureText: isPassword,
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }


}
