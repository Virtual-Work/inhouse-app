import 'dart:io';

import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/core/Services/Api.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/locator.dart';
import 'package:virtualworkng/model/uploadImageModel.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/util/customFunctions.dart';

var customF = locator<CustomFunction>();
var api = locator<Api>();

class StaffRegisteration extends StatefulWidget {
  @override
  _StaffRegisterationState createState() => _StaffRegisterationState();
}

class _StaffRegisterationState extends State<StaffRegisteration> {
List<String> genderList = new List<String>();
TextEditingController fNameController, lNameController, phoneNController,acctNameController, acctNumberController ;
bool processing = false;
List<String> getBanklistDisplay = new List<String>();
List<String> withdrawalList = new List<String>();
String _selectedW;
String _selectedBankNameid;



  @override
  void initState() {
    super.initState();
    fNameController = new TextEditingController();
    lNameController = new TextEditingController();
    phoneNController = new TextEditingController();
    acctNameController = new TextEditingController();
    acctNumberController = new TextEditingController();
    getBankData();
    loadPlan();
  }

  @override
  Widget build(BuildContext context) {
    var imagefile = Provider.of<UploadImageModel>(context);

  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.only(top: 18.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    width: 300.0,
                    height: 590,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            controller: fNameController,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              icon: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.orange,
                              ),
                              labelText: 'First Name',
                              labelStyle: AppTextStyle.inputLabelStyle(context),
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 5.0, bottom: 10.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            controller: lNameController,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              icon: Icon(
                                FontAwesomeIcons.userAlt,
                                color: Colors.orange,
                              ),
                              labelText: 'Last Name',
                              labelStyle: AppTextStyle.inputLabelStyle(context),
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 5.0, bottom: 10.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            controller: phoneNController,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              icon: GestureDetector(
                                child: Icon(
                                  FontAwesomeIcons.mobile,
                                  color: Colors.orange,
                                ),
                              ),
                              labelText: 'Phone Number',
                              labelStyle: AppTextStyle.inputLabelStyle(context),
                              hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0, ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 5.0, bottom: 10.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            controller: acctNameController,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              icon: GestureDetector(
                                child: Icon(
                                  FontAwesomeIcons.bandcamp,
                                  color: Colors.orange,
                                ),
                              ),
                              labelText: 'Account Name',
                              labelStyle: AppTextStyle.inputLabelStyle(context),
                              hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0, ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 5.0, bottom: 10.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            controller: acctNumberController,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              icon: GestureDetector(
                                child: Icon(
                                  FontAwesomeIcons.piggyBank,
                                  color: Colors.orange,
                                ),
                              ),
                              labelText: 'Account Number',
                              labelStyle: AppTextStyle.inputLabelStyle(context),
                              hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0, ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: 5.0, left: 25.0, right: 25.0),
                          child: FindDropdown(
                            items: getBanklistDisplay,
                            label: "Choose Bank",
                            onChanged:(value){
                              _selectedBankNameid = value;
                            },
                            selectedItem: 'Access Bank',
                            validate: (String item) {
                              if (item == null)
                                return "Required field";
                              else if (item == "Access Bank")
                                return "Invalid item";
                              else
                                return null;
                            },
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 50,
                          child: DropdownButton<String>(
                            elevation: 6,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                            hint: Text(
                              "Withdrawal Plan",
                              textAlign: TextAlign.center,
                            ),
                            value: _selectedW,
                            onChanged: (String value) {
                              setState(() {
                                _selectedW = value;
                              });
                              print(_selectedW);
                            },
                            items: withdrawalList.map((String val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      val.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.orange,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                            isExpanded: true,
                          ),
                        ),
                        //  Padding(
                        //     padding: EdgeInsets.only(
                        //         top: 10.0, bottom: 20.0, left: 25.0, right: 25.0),
                        //     child: Row(children: <Widget>[
                        //       Icon(FontAwesomeIcons.genderless, color: Colors.orange,),
                        //       SizedBox(width: 15.0,),
                        //       Container(
                        //         width: 200,
                        //         height: 50,
                        //         child: DropdownButton<String>(
                        //       elevation: 6,
                        //       style: TextStyle(
                        //         color: AppColor.primaryColor,
                        //         fontSize: 15.0,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //       hint: Text(
                        //         "Gender",
                        //         textAlign: TextAlign.center,
                        //       ),
                        //       value: _selectgender,
                        //       onChanged: (String value) {
                        //         setState(() {
                        //           _selectgender = value;
                        //         });
                        //         print(_selectgender);
                        //       },
                        //       items: genderList.map((String val) {
                        //         return DropdownMenuItem<String>(
                        //           value: val,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: <Widget>[
                        //               Text(
                        //                 val.toString(),
                        //                 textAlign: TextAlign.center,
                        //                 style: TextStyle(
                        //                   color: Colors.orange,
                        //                 ),
                        //               )
                        //             ],
                        //           ),
                        //         );
                        //       }).toList(),
                        //       isExpanded: true,
                        //     ),
                        //       )
                        //     ],)
                        //   ),
                      ],
                    ),
                  )
              ),
              (processing ? Container(
                margin: EdgeInsets.only(top: 550.0),
                child: customF.loadingWidget(),
              ) : Container(
                  margin: EdgeInsets.only(top: 561.0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColor.d,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                    ],
                    gradient: new LinearGradient(
                        colors: [
                          AppColor.thirdColor,
                          AppColor.nearlyDarkBlue,
                        ],
                        begin: const FractionalOffset(0.2, 0.2),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: AppColor.thirdColor,
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          "PROCEED",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: "WorkSansBold"),
                        ),
                      ),
                      onPressed: () {
                    storeDetails(imagefile);
                      }

                  )
              ))
            ],
          ),
          SizedBox(height: 100.0,)
        ],
      ),
    ),
  );
  }

  storeDetails(UploadImageModel imageFile)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString(StaffEmail);
    String fname = fNameController.text.trim();
    String lname = lNameController.text.trim();
    String phone = phoneNController.text.trim();
    String accountname = acctNameController.text.trim();
    String accountN = acctNumberController.text.trim();
    String bankN = _selectedBankNameid;
    String withdrawal = _selectedW;

    if(fname.isEmpty || lname.isEmpty || phone.isEmpty || accountname.isEmpty
        || accountN.isEmpty || bankN.isEmpty || withdrawal.isEmpty) {
      customF.showToast(message: 'Empty field detected');

    }else if(phone.trim().length < 11 || phone.trim().length > 11){
      customF.showToast(message: 'Your PhoneNumber must be 11 numbers in length');

      }else if(imageFile.getImageFile == null){
      customF.showToast(message: 'No image selected');
    }else{
      startLoading();
      api.addMoreDetailsToStaff(fName: fname, staffEmail: email,
          lName: lname, phone: phone, file: imageFile.getImageFile,
      accountN: accountname, accountNo: accountN, bankName: bankN, withdrawalPlan: withdrawal).then((v){
        startLoading();
        if (v != null) {
          // print(v.documentID);
          stopLoading();
        } else {
          stopLoading();
          customF.showToast(message: 'Successfully Update');
          Navigator.pushReplacementNamed(context, staffDashboardRoute);
        }
      });
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

getBankData() {
  getBanklistDisplay.add('Access Bank');
  getBanklistDisplay.add('Citibank');
  getBanklistDisplay.add('Coronation Merchant Bank');
  getBanklistDisplay.add('Diamond Bank');
  getBanklistDisplay.add('Ecobank');
  getBanklistDisplay.add('Enterprise Bank');
  getBanklistDisplay.add('First Bank');
  getBanklistDisplay.add('FBN Holdings PLC');
  getBanklistDisplay.add('FBN Merchant Bank');
  getBanklistDisplay.add('FCMB Group PLC');
  getBanklistDisplay.add('First City Monument Bank');
  getBanklistDisplay.add('FSDH Merchant Bank');
  getBanklistDisplay.add('Guaranty Trust Bank');
  getBanklistDisplay.add('Heritage Bank');
  getBanklistDisplay.add('Jaiz Bank');
  getBanklistDisplay.add('Providus Bank');
  getBanklistDisplay.add('Rand Merchant Bank');
  getBanklistDisplay.add('Sterling Bank');
  getBanklistDisplay.add('Stanbic IBTC Bank');
  getBanklistDisplay.add('Stanbic IBTC Holdings PLC');
  getBanklistDisplay.add('Skye Bank');
  getBanklistDisplay.add('Standard Chartered Bank');
  getBanklistDisplay.add('Suntrust Bank');
  getBanklistDisplay.add('United Bank For Africa');
  getBanklistDisplay.add('Unity Bank');
  getBanklistDisplay.add('Union Bank');
  getBanklistDisplay.add('Wema Bank');
  getBanklistDisplay.add('Zenith Bank');
}

loadPlan(){
  withdrawalList.add("Bi-monthly");
  withdrawalList.add("monthly");
}

}
