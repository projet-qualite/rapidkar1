import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rapidkar/classes/owner.dart';
import 'package:rapidkar/data/data_http.dart';
import 'package:rapidkar/data/data_test.dart';
import 'package:rapidkar/other_sign_log/bezier.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'loginpage.dart';


class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _controllerNom = TextEditingController();
  TextEditingController _controllerPrenom = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNumero = TextEditingController();
  TextEditingController _controllerMDP = TextEditingController();
  TextEditingController _controllerCMDP = TextEditingController();





  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title,TextEditingController controller, {bool isPassword = false}) {
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
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }



  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Vous avez déjà un compte ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Se connecter',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Image.asset('images/logo.jpg');

  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Nom",_controllerNom),
        _entryField("Prenoms",_controllerPrenom),
        _entryField("Email",_controllerEmail),
        _entryField("Numéro de téléphone", _controllerNumero),
        _entryField("Mot de passe",_controllerMDP,isPassword: true),
        _entryField("Confirmer le mot de passe",_controllerCMDP,isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr;
    pr = new ProgressDialog(context);
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
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 100.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    _title(),

                    _emailPasswordWidget(),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 85.0,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: RaisedButton(
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        onPressed: () async{
                          int vrai = 0;

                          for(int i=0;i<all_owner.length;++i)
                            {
                              if(_controllerEmail.text == all_owner[i].email)
                                {
                                  showCenterShortToast('Email existe déjà');
                                  vrai = 1;
                                }
                            }
                          if (!(_controllerEmail.text.contains('@') ||
                              _controllerEmail.text.contains('.') || vrai == 1)) {
                            showCenterShortToast('Email incorrecte');
                          }
                          else {
                            if (_controllerMDP.text != _controllerCMDP.text) {
                              showCenterShortToast("Mots de passe différents");
                            }
                            else {
                              if (_controllerMDP.text.length < 8) {
                                showCenterShortToast(
                                    "Mots de passe trop court (minimum 8 caractères)");
                              }
                              else {
                                if (_controllerNom.text == '' ||
                                    _controllerPrenom.text == '') {
                                  showCenterShortToast(
                                      "Nom ou prenom invalide");
                                }
                                else {
                                  currentOwner.firstname = _controllerNom.text;
                                  currentOwner.lastname =
                                      _controllerPrenom.text;
                                  currentOwner.pwd = _controllerMDP.text;
                                  currentOwner.email = _controllerEmail.text;
                                  currentOwner.phone = _controllerNumero.text;

                                  print('ddddaaaaaaaaaaaaaaaaaaaaaattttttttttttttteeeeeeeee ${currentOwner.isMemberSince}');

                                  pr.show();
                                  createOwner(currentOwner).then((response) {
                                    setState(() {
                                      Map<String, dynamic> list = json.decode(
                                          response.body);
                                      print(
                                          'ooooooooooooooooooooooooooooooooo $list');
                                      currentOwner = Owner.fromJson2(list);
                                      currentOwner.pwd = _controllerMDP.text;

                                      Future.delayed(Duration(seconds: 3))
                                          .then((value) {
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
                                    });
                                  });






                                }
                              }
                            }
                          }
                        },
                        child: new Text("Inscription",
                          style: TextStyle(fontSize: 20.0,
                              color: Colors.white),),

                      ),
                    ),


                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}