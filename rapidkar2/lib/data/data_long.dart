
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getEmailOwner() async{
  final prefs = await SharedPreferences.getInstance();
  final mail = prefs.getString('_email_owner');


  return mail;

}

Future<String> getPwdOwner() async{

  final prefs = await SharedPreferences.getInstance();
  final pwd = prefs.getString('_pwd_owner');

  if(pwd ==  null)
  {
    return '';
  }

  return pwd;
}