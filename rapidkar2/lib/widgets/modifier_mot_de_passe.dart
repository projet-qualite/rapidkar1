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

import 'home_screen.dart';


class ModifierMDP extends StatefulWidget {
  ModifierMDP({Key key,this.owner}) : super(key: key);
  final Owner owner;

  @override
  _ModifierMDP createState() => _ModifierMDP();
}

class _ModifierMDP extends State<ModifierMDP> {

  TextEditingController _controllerMDP = TextEditingController();
  TextEditingController _controllerNewMDP = TextEditingController();
  TextEditingController _controllerConfirmNewMDP = TextEditingController();




  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _controllerMDP.text = widget.owner.pwd;

  }


  @override
  Widget build(BuildContext context) {

    ProgressDialog pr;
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Modification en cours..',
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
          title: Text('Modifier le mot de passe'),
          backgroundColor: Colors.orange[500],
        ),
        body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(50),
              child: Column(
                  children: <Widget>[

                    _entryField('Mot de passe',_controllerMDP,isPassword: true),
                    _entryField('Nouveau mot de passe',_controllerNewMDP,isPassword: true),
                    _entryField('Confirmation mot de passe',_controllerConfirmNewMDP,isPassword: true),

                    InkWell(
                        onTap: (){


                            if(_controllerConfirmNewMDP.text != _controllerNewMDP.text)
                            {
                              showCenterShortToast("Mots de passe différents");
                            }
                            else{
                              if(_controllerNewMDP.text.length<8)
                              {
                                showCenterShortToast("Mots de passe trop court (minimum 8 caractères)");
                              }
                              else{

                                pr.show();
                                widget.owner.pwd = _controllerNewMDP.text;


                                updateOwner(widget.owner).then((response) {
                                  setState(() {
                                    Map<String, dynamic> list = json.decode(response.body);
                                    print('ooooooooooooooooooooooooooooooooo $list');
                                    currentOwner = Owner.fromJson(list);
                                    currentOwner.pwd = _controllerNewMDP.text;

                                    Future.delayed(Duration(seconds: 3)).then((value) {
                                      pr.hide().whenComplete(() {
                                        Navigator.push(this.context,
                                            MaterialPageRoute(builder: (context) {
                                              currentIndex = 3;
                                              return MyHomePage();
                                            }));
                                      });
                                    });


                                  });
                                });


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

  void showCenterShortToast(String texte) {
    Fluttertoast.showToast(
        msg: texte,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }
}
