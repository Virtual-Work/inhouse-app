import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  //Save Staff Email only in sharePref
  saveStaffInfo({String mail})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(StaffEmail, mail);
  }
  //Saving other details like, privilege, FirstName, LastName
  saveStaffdetails({String privilege, firstName, lastName})async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(pref_privilege, privilege);
    prefs.setString(pref_firstName, firstName);
    prefs.setString(pref_lastName, lastName);
  }

  loadingWidget(){
    return Center(
      child: SpinKitPumpingHeart(color: AppColor.deep, duration: new Duration(seconds: 1),),
    );
  }
  loadingWidgetInWhite(){
    return Center(
      child: SpinKitPumpingHeart(color: AppColor.white, duration: new Duration(seconds: 1),),
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

  //0 - Pending
  //1 - Successful
  //2 - Delivered
  // 3 - Failed
  Color transactionIconColor(int status) {

    switch (status) {
      case 0:
      //0 - Pending
        return Color(0xFFB6900B);
        break;

      case 1:
      //1 - Successful
        return  Color(0xFF4E8A41);

        break;

      case 2:
      //2 - Delivered
        return Color(0xFF006E52);
        break;

      case 3:
      // 3 - Failed
        return  Color(0xFFED1B24);
        break;

      default:
        return  Colors.purpleAccent;
    }
  }

  //0 - Pending
  //1 - Successful
  //2 - Delivered
  // 3 - Failed
  Icon transactionIcon(int status) {
    switch (status) {
      case 0:
      //0 - Pending
        return Icon(
          Icons.error_outline,
          size: 22.0,
          color: Color(0xFFB6900B),
        );
        break;

      case 1:
      //1 - Successful
        return  Icon(
          Icons.check,
          size: 22.0,
          color: Color(0xFF006E52),
        );

        break;

      case 2:
      //2 - Delivered
        return  Icon(
          Icons.done_all,
          size: 22.0,
          color: Color(0xFF006E52),
        );
        break;

        case 3:
        // 3 - Failed
        return  Icon(
        Icons.error,
        size: 22.0,
        color: Color(0xFFED1B24),
    );
        break;

      default:
        return Icon(
          Icons.account_balance_wallet,
          size: 22.0,
          color: AppColor.primaryColorDark,
        );
    }
  }

  String transactionStatus(int status) {
    //0 - Pending
    //1 - Successful
    //2 - Delivered
    // 3 - Failed
    switch (status) {
      case 0:
        return 'Pending';
        break;

      case 1:
        return  'Successful';

        break;

      case 2:
        return  'Delivered';
        break;

      case 3:
        return  'Failed';
        break;

      default:
        return '';
    }
  }

  int TransacStatus(String status) {
    switch (status) {
      case 'Successful':
        return 0;
        break;

      case 'Pending / Failed':
        return 1;
        break;
    }
  }

  Widget getStatusWidget (String status){

    if(TransacStatus(status) == 1){
      return Icon(
        Icons.error,
        size: 22.0,
        color: Colors.red,
      );
    }else{
      return Icon(
        Icons.check,
        size: 22.0,
        color: Colors.green,
      );
    }
  }

  //For Report
  //0 = Pending
  //1 = Approve
  //2 = Decline
  String reportStatus(int status) {
    switch (status) {
      case 0:
        return 'Pending';
        break;

      case 1:
        return  'Approve';

        break;

      case 2:
        return  'Decline';
        break;

      default:
        return '';
    }
  }
}