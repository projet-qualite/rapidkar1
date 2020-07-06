import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rapidkar/classes/favorite.dart';
import 'package:rapidkar/classes/owner.dart';
import 'package:rapidkar/data/data_http.dart';
import 'package:rapidkar/data/data_test.dart';
import 'package:rapidkar/other_sign_log/bezier.dart';
import 'package:rapidkar/widgets/signuppage.dart';

import 'home_screen.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xfffbb448), Color(0xfff7892b)])),
      child: Text(
        'Se connecter',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[


        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Vous n\'avez pas de compte ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Créer un compte',
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
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerMDP = TextEditingController();

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email",_controllerEmail),
        _entryField("Mot de passe", _controllerMDP,isPassword: true),
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
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(height: 50),
                      _emailPasswordWidget(),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 85.0,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: RaisedButton(
                          color: Colors.orange[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          onPressed: () async{

                          pr.show();
                          if(!(_controllerEmail.text.contains("@")) || _controllerEmail.text == '')
                            {
                              showCenterShortToast('Email incorrecte');
                            }
                          else{
                            if(_controllerMDP.text == '')
                              {
                                showCenterShortToast('Mot de passe invalide');
                              }
                            else{
                              logOwner(_controllerEmail.text,_controllerMDP.text).then((response) {
                                setState(() {
                                  Iterable list = json.decode(response.body);
                                  owners = list.map((model) => Owner.fromJson(model)).toList();

                                  if(owners.isEmpty)
                                  {
                                    pr.hide();
                                    showCenterShortToast2();
                                  }
                                  else{
                                    currentOwner = owners.first;
                                    fetchFavoriteOfOwner(currentOwner.id).then((response) {
                                      setState(() {
                                        Iterable list = json.decode(response.body);
                                        favoritesOfOwner = list.map((model) => Favorite.fromJson(model)).toList();
                                        print('ffffffffffffffffaaaaaaaaaaaaaaaav ${favoritesOfOwner[0].fan}');
                                      });
                                    });
                                    //currentOwner.pwd = _controllerMDP.text;
                                    print('ooooooooooooooooooooooooooooooooooooooo ${currentOwner.pwd}');
                                    currentOwner.pwd = _controllerMDP.text;
                                    print('ooooooooooooooooooooooooooooooooooooooo ${currentOwner.pwd}');
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
                                  }

                                });
                              });

                            }
                          }












                          },
                          child: new Text("Se connecter",
                            style: TextStyle(fontSize: 20.0,
                                color: Colors.white),),

                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: Text('Mot de passe oublié ?',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                      _createAccountLabel(),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ));
  }

  void showCenterShortToast2() {
    Fluttertoast.showToast(
        msg: "Identifiants incorrects",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }
}