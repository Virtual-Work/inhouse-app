//import 'package:flutter/material.dart';
//import 'package:steps/steps.dart';
//import 'package:virtualworkng/style/AppColor.dart';
//import 'package:virtualworkng/style/AppFontSizes.dart';
//import 'package:virtualworkng/style/AppTextStyle.dart';
//import 'package:virtualworkng/ui/AdminRegister1.dart';
//
//class Test extends StatefulWidget {
//
//  @override
//  _TestState createState() => _TestState();
//}
//
//class _TestState extends State<Test> {
//  bool _status = true;
//
//  final FocusNode myFocusNode = FocusNode();
//
//  final TextEditingController NameController = new TextEditingController();
//
//  final TextEditingController EmailController = new TextEditingController();
//
//  final TextEditingController MobileController = new TextEditingController();
//
//  final TextEditingController UserIDcontroller = new TextEditingController();
//
//  final TextEditingController RefercodeController = new TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          backgroundColor: AppColor.primaryColorDark,
//          title: Center(child: Text('Olajire Abdullah', style: TextStyle(
//              fontFamily: "Metropolis",
//              fontFamilyFallback: ["RobotoRegular"],
//              fontSize: AppFontSizes.medium,
//              fontWeight: FontWeight.w400,
//              color: AppColor.white))),
//          leading: Text(''),
//          actions: <Widget>[
//            Padding(
//              padding: const EdgeInsets.only(right: 10.0),
//              child: InkWell(
//                highlightColor: Colors.yellowAccent,
//                borderRadius:
//                BorderRadius.all(Radius.circular(32.0)),
//                child: Icon(
//                  Icons.power_settings_new,
//                  color: Colors.red,
//                ),
//              ),
//            ),
//          ],
//        ),
//        body:SingleChildScrollView(
//          child: Container(
//            child: Column(
//              children: <Widget>[
//                Container(
//                  height: 200.0,
//                  color: Colors.white,
//                  child:  Column(
//                    children: <Widget>[
//                      Padding(
//                        padding: EdgeInsets.only(top: 1.0),
//                        child: new Stack(fit: StackFit.loose, children: <Widget>[
//                          Row(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Container(
//                                  width: 140.0,
//                                  height: 140.0,
//                                  decoration: new BoxDecoration(
//                                    shape: BoxShape.circle,
//                                    image:  DecorationImage(
//                                      image:  ExactAssetImage(
//                                          'assets/images/img/admin.png'),
//                                      fit: BoxFit.cover,
//                                    ),
//                                  )),
//                            ],
//                          ),
//                          Padding(
//                              padding: EdgeInsets.only(top: 90.0, right: 100.0),
//                              child: new Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: <Widget>[
//                                  new CircleAvatar(
//                                    backgroundColor: AppColor.primaryColorDark,
//                                    radius: 25.0,
//                                    child: new Icon(
//                                      Icons.camera_alt,
//                                      color: Colors.white,
//                                    ),
//                                  )
//                                ],
//                              )),
//                        ]),
//                      )
//                    ],
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(left: 8.0, right: 9.0, bottom: 15.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    mainAxisSize: MainAxisSize.max,
//                    children: <Widget>[
//                      Text('Personal Information',
//                        style: TextStyle(
//                            fontSize: 15.0,
//                            fontWeight: FontWeight.bold),
//                      ),
//                      Column(
//                        mainAxisAlignment: MainAxisAlignment.end,
//                        mainAxisSize: MainAxisSize.min,
//                        children: <Widget>[
//                          _status ? _getEditIcon() : new Container(),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  color: AppColor.primaryColor,
//                  child: Padding(
//                    padding: EdgeInsets.only(bottom: 20.0, left: 15, right: 10),
//                    child: new Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        TextField(
//                          decoration: InputDecoration(
//                            border: const UnderlineInputBorder(),
//                            labelText: 'Email',
//                            labelStyle: AppTextStyle.inputLabelStyle(context),
//                            hintStyle: TextStyle(
//                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                          ),
//                          enabled: !_status, controller: MobileController,
//                        ),
//                        TextField(
//                          keyboardType: TextInputType.number,
//                          decoration: InputDecoration(
//                            border: const UnderlineInputBorder(),
//                            labelText: 'Phone Number',
//                            labelStyle: AppTextStyle.inputLabelStyle(context),
//                            hintStyle: TextStyle(
//                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                          ),
//                          enabled: !_status, controller: MobileController,
//                        ),
//                        TextField(
//                          keyboardType: TextInputType.text,
//                          decoration: InputDecoration(
//                            border: const UnderlineInputBorder(),
//                            labelText: 'Bank Name',
//                            labelStyle: AppTextStyle.inputLabelStyle(context),
//                            hintStyle: TextStyle(
//                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                          ),
//                          enabled: !_status, controller: MobileController,
//                        ),
//                        TextField(
//                          keyboardType: TextInputType.text,
//                          decoration: InputDecoration(
//                            border: const UnderlineInputBorder(),
//                            labelText: 'Account Name',
//                            labelStyle: AppTextStyle.inputLabelStyle(context),
//                            hintStyle: TextStyle(
//                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                          ),
//                          enabled: !_status, controller: MobileController,
//                        ),
//                        TextField(
//                          keyboardType: TextInputType.text,
//                          decoration: InputDecoration(
//                            border: const UnderlineInputBorder(),
//                            labelText: 'Account Number',
//                            labelStyle: AppTextStyle.inputLabelStyle(context),
//                            hintStyle: TextStyle(
//                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                          ),
//                          enabled: !_status, controller: MobileController,
//                        ),
//                        TextField(
//                          keyboardType: TextInputType.text,
//                          decoration: InputDecoration(
//                            border: const UnderlineInputBorder(),
//                            labelText: 'Withdrawl Plan',
//                            labelStyle: AppTextStyle.inputLabelStyle(context),
//                            hintStyle: TextStyle(
//                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                          ),
//                          enabled: !_status, controller: MobileController,
//                        ),
//                        !_status ? _getActionButtons() : new Container(),
//                        SizedBox(height: 20.0,),
//                      ],
//                    ),
//                  ),
//                )
//              ],
//            ),
//          ),
//        ),);
//  }
//
//  Widget _getActionButtons() {
//    return Padding(
//      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
//      child: new Row(
//        mainAxisSize: MainAxisSize.max,
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: <Widget>[
//          Expanded(
//            child: Padding(
//              padding: EdgeInsets.only(right: 10.0),
//              child: Container(
//                  child: new RaisedButton(
//                    child: new Text("Save"),
//                    textColor: Colors.white,
//                    color: Colors.green,
//                    onPressed: () {
//                      setState(() {
//                        _status = true;
//                        FocusScope.of(context).requestFocus(new FocusNode());
//                      });
//                    },
//                    shape: new RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(20.0)),
//                  )),
//            ),
//            flex: 2,
//          ),
//          Expanded(
//            child: Padding(
//              padding: EdgeInsets.only(left: 10.0),
//              child: Container(
//                  child: new RaisedButton(
//                    child: new Text("Cancel"),
//                    textColor: Colors.white,
//                    color: Colors.red,
//                    onPressed: () {
//                      setState(() {
//                        _status = true;
//                        FocusScope.of(context).requestFocus(new FocusNode());
//                      });
//                    },
//                    shape: new RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(20.0)),
//                  )),
//            ),
//            flex: 2,
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget _getEditIcon() {
//    return new GestureDetector(
//      child: new CircleAvatar(
//        backgroundColor: AppColor.primaryColorDark,
//        radius: 14.0,
//        child: new Icon(
//          Icons.edit,
//          color: Colors.white,
//          size: 16.0,
//        ),
//      ),
//      onTap: () {
//        setState(() {
//          _status = false;
//        });
//      },
//    );
//  }
//}
