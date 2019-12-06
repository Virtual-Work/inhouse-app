import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualworkng/core/Services/Api.dart';
import 'package:virtualworkng/core/Services/Authenticate/authentication.dart';
import 'package:virtualworkng/core/Services/Database/database.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/locator.dart';
import 'package:virtualworkng/screens/Countdown.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/ui/shared/background.dart';
import 'package:virtualworkng/util/customFunctions.dart';
import 'package:virtualworkng/widgets/InputWidget.dart';
import 'package:virtualworkng/widgets/noInternet.dart';
import 'package:virtualworkng/widgets/roundedRectButton.dart';


var authentication = locator<AuthService>();
var customF = locator<CustomFunction>();
var api = locator<Api>();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   bool processing = false;
   TextEditingController emailController = TextEditingController();
   TextEditingController passController = TextEditingController();
   TextEditingController retypePassController = TextEditingController();
   final FocusNode myFocusNodePassword1 = FocusNode();
   final FocusNode myFocusNodePassword2 = FocusNode();
   bool hideEmailUI = true;
   String holdEmail;
   bool _obscureP1 = true, _obscureP2 = true;
   int loginFailsTimer = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: OfflineBuilder(
          connectivityBuilder: (
              BuildContext context, ConnectivityResult connectivity,
              Widget child,) {
            final bool connected = connectivity != ConnectivityResult.none;
            return  Stack(
              fit: StackFit.expand,
              children: [
                Container(
                    color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                    child: (connected ? Stack(
                      children: <Widget>[
                        Background(),
                        ReactionUI(context)
                      ],
                    ) : NoInternetWidgets())
                ),
              ],
            );
          },
      child: Container()
      ));
  }


   ReactionUI(BuildContext context){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.3),
        ),
        Column(
          children: <Widget>[
            ///holds email header and inputField
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, bottom: 10),
                        child: Text(
                          "Email",
                          style: AppTextStyle.emailheaderSmall(context),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Center(
                            child: Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child:  Material(
                                  elevation: 15,
                                  shadowColor: AppColor.accents,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(30.0),
                                          topRight: Radius.circular(0.0))),

                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
                                    child: TextField(
                                      controller: emailController,
                                      style: AppTextStyle.editTextSmall(context),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "me@virtualwork.ng",
                                        hintStyle: AppTextStyle.inputHint(context),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  visible: hideEmailUI,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40, bottom: 10, top: 20),
                  child: Text(
                    "Password:",
                    style: AppTextStyle.emailheaderSmall(context),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child:  Material(
                            elevation: 15,
                            shadowColor: AppColor.accents,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(30.0),
                                    topRight: Radius.circular(0.0))),

                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
                              child: TextField(
                                controller: passController,
                                obscureText: _obscureP1,
                                focusNode: myFocusNodePassword1,
                                style: AppTextStyle.editTextSmall(context),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "*******",
                                    hintStyle: AppTextStyle.inputHint(context),
                                    suffixIcon: GestureDetector(
                                      child: Icon(
                                      FontAwesomeIcons.eye,
                                      color: AppColor.deep,
                                    ),
                                      onTap: _toggleP1)
                                ),

                              ),
                            ),
                          )
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 50),
                        child: Row(
                          children: <Widget>[
                          ],
                        ))
                  ],
                ),
                Visibility(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40, bottom: 10, top: 20),
                        child: Text(
                          "Retype Password:",
                          style: AppTextStyle.emailheaderSmall(context),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Center(
                            child: Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child:  Material(
                                  elevation: 15,
                                  shadowColor: AppColor.accents,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(30.0),
                                          topRight: Radius.circular(0.0))),

                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
                                    child: TextField(
                                      controller: retypePassController,
                                      obscureText: _obscureP2,
                                      focusNode: myFocusNodePassword2,
                                      style: AppTextStyle.editTextSmall(context),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "*******",
                                          hintStyle: AppTextStyle.inputHint(context),
                                          suffixIcon: GestureDetector(
                                            child: Icon(
                                            FontAwesomeIcons.eye,
                                            color: AppColor.deep,
                                          ),
                                          onTap: _toggleP2,)
                                      ),

                                    ),
                                  ),
                                )
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 50),
                              child: Row(
                                children: <Widget>[
                                ],
                              ))
                        ],
                      ),
                    ],
                  ),
                  visible: (hideEmailUI ? false : true),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
            ),
        GestureDetector( 
          child: (processing ? loginInAnimation() : 
          RoundedRecButton(title: 'Let\'s get Started', 
          gradientColor: [Color(0xFFffc107),  Color(0xFFff6d00)])),
           onTap: (){
             //sigIn();
               adminLogin();
//             if(holdEmail == null){
//               staffLogin();
//             }else{
//               createPassword();
//             }

          },
        )
          ],
        )
      ],
    );
  }
  
  loginInAnimation(){
   return Column(
      children: <Widget>[
        SpinKitPumpingHeart(color: AppColor.deep, duration: new Duration(seconds: 1),),
        SizedBox(height: 5,),
        SizedBox(
          child: ScaleAnimatedTextKit(
              text: [
                "Checking Authentication...",
                "      Please wait...           ",
              ],
              textAlign: TextAlign.center,
              textStyle: AppTextStyle.siginText(context)
            // or Alignment.topLeft
          ),
        ),
      ],
    );
  }

   void _toggleP1() {
     setState(() {
       _obscureP1 = !_obscureP1;
     });
   }

   void _toggleP2() {
     setState(() {
       _obscureP2 = !_obscureP2;
     });
   }

sigIn()async{
  //checking if it's login Successfully
  startLoading();
  dynamic _result = await authentication.signInAnonymous();

  if(_result == null){ // SigIn not successful.
     stopLoading();

  }else{ //Successfully signed in
  stopLoading();
//Navigator.pushNamed(context, staffDashboardRoute);
  }
}

startLoading(){
  setState(() {
    processing = true;
  });
}

stopLoading(){
  setState(() {
    processing = false;
  });
}

adminLogin()async{
    String inputmail = emailController.text.trim();
    String inputpass = passController.text.trim();

    if(inputmail.isEmpty || inputpass.isEmpty) {
      customF.showToast(message: 'Empty field detected');

    }else if(!customF.isVirtualWorkNGMail(mail: inputmail)){
      customF.showToast(message: 'Invalid Email');
    }else{
      String mail, pass;
      startLoading();
      api.getA().then((v){
        if(v != null){
          for(var doc in v.documents){
            mail = doc.data['AdminEmail'];
            pass = doc.data['AdminPassword'];
//         print(doc.data['AdminPassword']);
          }

          if(mail != null){
            if(mail == inputmail && pass == inputpass){
              customF.saveAdminInfo(mail: mail);
              stopLoading();
                Navigator.pushReplacementNamed(context, adminDashboardRoute);
            }else{
              addingTimer(); //adding timer
              customF.showToast(message: 'Invalid Login Details');
              stopLoading();
            }
          }else{
            customF.showToast(message: 'Invalid Login Details');
            stopLoading();
          }

        }else{
          customF.showToast(message: 'Error, please retry');
          print('Null Output');
          stopLoading();
        }
      });
    }

}

staffLogin(){
    String mail = emailController.text.trim();
    String severMail;
    startLoading();
    api.staffSignIn(email: mail).then((v){
      if(v != null){
        for(var doc in v.documents){
          severMail = doc.data['Email'];
         print(doc.data['Email']);
        }
        if(severMail != null){
          if(mail == severMail){
            customF.showToast(message: 'Success');
            setState(() {
              holdEmail = severMail; //hold the email value for me
              hideEmailUI = false; //Display Entering Password UI
            });
            stopLoading();
          }else{
            customF.showToast(message: 'Invalid Login Details');
            stopLoading();
          }
        }else{
          customF.showToast(message: 'Invalid Login Details');
          stopLoading();
        }

      }else{
        customF.showToast(message: 'Error, please retry');
        print('Null Output');
        stopLoading();
      }
    });
//    bool istrue;
//  String inputmail = emailController.text.trim();
//  if(inputmail.isEmpty){
//    customF.showToast(message: 'Empty field detected');
//  }else{
//    String mail;
//
//    //print(.documents[0].data);
//
////      if(v != null){
////
////        stopLoading();
//////        for(int i =0; i < v.documents.length; i++){
//////          if(v.documents[i].documentID == 'newads.xom'){
//////            istrue = true;
//////            print(v.documents[i].documentID);
//////          }else{
//////            istrue = false;
//////            print('No data found');
//////          }
//////        }
////      }else{
////        customF.showToast(message: 'Error, please retry');
////        print('Null Output');
////        stopLoading();
////      }
//   // });
//  }

}

createPassword(){
  String pass1 = passController.text.trim();
  String pass2 = retypePassController.text.trim();

  if(pass1.toString().isEmpty || pass2.toString().isEmpty){
    customF.showToast(message: 'Empty field Detected');

  }else if(pass1.toString() != pass2.toString()){
    customF.showToast(message: 'Password not match');
  }else{
    startLoading();
   api.createPIN(staffEmail: holdEmail, password: pass1).then((v) {
     if (v != null) {
       // print(v.documentID);
       stopLoading();
     } else {
       stopLoading();
       customF.saveStaffInfo(mail: holdEmail);// save info sharePref
       Navigator.pushReplacementNamed(context, staffDashboardRoute);
     }
   });
  }
}

@override
  void dispose() {
    super.dispose();
    myFocusNodePassword1.dispose();
    myFocusNodePassword2.dispose();
  }

  addingTimer(){
    setState(() {
      loginFailsTimer++;
    });
    if(loginFailsTimer == 5){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => CountDownTimer(),));
    }
  }

}

