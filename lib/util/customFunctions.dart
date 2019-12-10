import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';

class CustomFunction{

  showToast({String message}){
     Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: AppColor.orange,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  //Save Admin Info in sharePref
  saveAdminInfo({String mail})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AdminMail, mail);
  }
  //Save User Info in sharePref
  saveStaffInfo({String mail})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(StaffEmail, mail);
  }

  loadingWidget(){
    return Center(
      child: CircularProgressIndicator()
    );
  }

  errorWidget(String message){
    return Center(child: Text(message, textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, color: Colors.red),),);
  }


  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool isVirtualWorkNGMail({String mail}){
    if(validateEmail(mail)){
      int getAtindex = mail.indexOf('@');
      String value = mail.substring(getAtindex);
      print(mail);
      if(value == '@virtualwork.ng'){
       return true; //If it's predefine mail Go ahead. else Failed;;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }

  Widget getInformationMessage(String message){
    return Center(child: Text(message,
      textAlign: TextAlign.center,
      style: TextStyle( fontWeight: FontWeight.w900, color: Colors.grey[100]),));
  }
}