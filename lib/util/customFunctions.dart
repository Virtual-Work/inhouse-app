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

  detailsDialog({String title, status, supervisors, BuildContext context}){
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromRight,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.w500),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.orange,
        ),
      ),
      titleStyle: AppTextStyle.headerSmall(context),
    );
    return Alert(
        context: context,
        title: 'Project Name: $title',
        style: alertStyle,
        type: AlertType.none,
      buttons: [
        DialogButton(
          color: AppColor.teal,
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
      ],
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Supervisor:  $supervisors",
                    style: TextStyle(
                        inherit: true,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Colors.black),
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Status:  $status",
                    style: TextStyle(
                        inherit: true,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Colors.black),
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Divider(),
          ],
        )).show();
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
}