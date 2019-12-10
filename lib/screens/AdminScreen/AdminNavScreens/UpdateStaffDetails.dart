
//THIS IS THE PREVIOUS VERSION, BUT I WAST TOLD TO ADD SOME FEACTURES TO IT


//import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:virtualworkng/core/Services/Api.dart';
//import 'package:virtualworkng/locator.dart';
//import 'package:virtualworkng/style/AppColor.dart';
//import 'package:virtualworkng/style/AppTextStyle.dart';
//import 'package:virtualworkng/util/customFunctions.dart';
//
//var api = locator<Api>();
//var customF = locator<CustomFunction>();
//
//class UpdateStaffDetails extends StatefulWidget {
//  final Email, previlege;
// const UpdateStaffDetails({this.Email, this.previlege});
//
//  @override
//  _UpdateStaffDetailsState createState() => _UpdateStaffDetailsState();
//}
//
//class _UpdateStaffDetailsState extends State<UpdateStaffDetails> {
//  TextEditingController staffMailController;
//  List<String> _previdleg = new List<String>();
//  String _selectedPrevidleg;
//  bool processing = false;
//
//  @override
//  void initState() {
//    super.initState();
//    add();
//    staffMailController = TextEditingController();
//    staffMailController.text = widget.Email;
//    _selectedPrevidleg = widget.previlege;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return  Center(
//      child: Dialog(
//        insetAnimationDuration: Duration(minutes: 1),
//        elevation: 10.0,
//        insetAnimationCurve: Curves.fastOutSlowIn,
//        child: Padding(
//          padding: const EdgeInsets.all(16.0),
//          child: SingleChildScrollView(
//            child: Column(
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.only(top: 15.0),
//                  child: Text(
//                    "Edit staff privilege",
//                    style: TextStyle(
//                        inherit: true,
//                        fontWeight: FontWeight.w500,
//                        fontSize: 15.0,
//                        color: Colors.orange),
//                    overflow: TextOverflow.fade,
//                    textAlign: TextAlign.center,
//                  ),
//                ),
//                Row(
//                  children: <Widget>[
//                    Icon(FontAwesomeIcons.user, color: Colors.orange,),
//                    SizedBox(width: 15.0,),
//                    Container(
//                      width: 200,
//                      height: 50,
//                      child: TextField(
//                        enabled: false,
//                        keyboardType: TextInputType.text,
//                        controller: staffMailController,
//                        decoration: InputDecoration(
//                          border: const UnderlineInputBorder(),
//                          labelText: 'Staff Email',
//                          labelStyle: AppTextStyle.inputLabelStyle(context),
//                          hintStyle: TextStyle(
//                              fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                        ),
//
//                      ),
//                    ),
//                  ],
//                ),
//                Padding(
//                    padding: EdgeInsets.only(
//                        top: 10.0, bottom: 20.0,),
//                    child: Row(children: <Widget>[
//                      Icon(FontAwesomeIcons.user, color: Colors.orange,),
//                      SizedBox(width: 15.0,),
//                      Container(
//                        width: 180,
//                        height: 50,
//                        child: DropdownButton<String>(
//                          elevation: 6,
//                          style: TextStyle(
//                            color: AppColor.primaryColor,
//                            fontSize: 15.0,
//                            fontWeight: FontWeight.w500,
//                          ),
//                          hint: Text(
//                            "Privilege ",
//                            textAlign: TextAlign.center,
//                          ),
//                          value: _selectedPrevidleg,
//                          onChanged: (String value) {
//                            setState(() {
//                              _selectedPrevidleg = value;
//                            });
//                            print(_selectedPrevidleg);
//                          },
//                          items: _previdleg.map((String val) {
//                            return DropdownMenuItem<String>(
//                              value: val,
//                              child: Row(
//                                mainAxisAlignment:
//                                MainAxisAlignment.spaceBetween,
//                                children: <Widget>[
//                                  Text(
//                                    val.toString(),
//                                    textAlign: TextAlign.center,
//                                    style: TextStyle(
//                                      color: Colors.orange,
//                                    ),
//                                  )
//                                ],
//                              ),
//                            );
//                          }).toList(),
//                          isExpanded: true,
//                        ),
//                      )
//                    ],)
//                ),
//                processing ? CircularProgressIndicator(backgroundColor: AppColor.deep00,) : RaisedButton(
//                  child: Text("Proceed"),
//                  splashColor: AppColor.orange,
//                  elevation: 10,
//                  animationDuration: Duration(seconds: 5),
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(20.0)
//                  ),
//                  color: AppColor.primaryColorDark,
//                  textColor: Colors.white,
//                  onPressed: (){
//                    updateStaff(); //Editing and Updating  staff priviledge to the Server.
//                  },
//                ),
//                SizedBox(height: 10.0),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//  updateStaff(){
////    startLoading();
////    api.editStaff(staffEmail: widget.Email, priviledge: _selectedPrevidleg).then((v) {
////      if (v != null) {
////        // print(v.documentID);
////        stopLoading();
////      } else {
////        stopLoading();
////        customF.showToast(message: 'Successfully Update');
////        Navigator.pop(context);
////      }
////    });
//  }
//
//  add(){
//    _previdleg.add('Staff');
//    _previdleg.add('supervisor');
//  }
//
//  startLoading(){
//    setState(() {
//      processing = true;
//    });
//  }
//
//  stopLoading(){
//    setState(() {
//      processing = false;
//    });
//  }
//}
