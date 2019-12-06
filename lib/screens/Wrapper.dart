import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtualworkng/model/UserModel.dart';
import 'package:virtualworkng/screens/LoginScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffnavigationHomeScreen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //This would change if User Logs in or logs out in (Real time)
  //   final user = Provider.of<User>(context);
    
  //   if(user == null){

  //     //No user login, so display Login Screen
  //   return LoginScreen();

  //   }else{
  //  print('******USER ${user.uID}');
  //     return StaffnavigationHomeScreen();
  //   }
   return LoginScreen();
  }
}