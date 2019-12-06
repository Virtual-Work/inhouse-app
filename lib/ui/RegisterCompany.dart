import 'dart:io';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';

class RegisterCompany extends StatefulWidget {
  @override
  _RegisterCompanyState createState() => _RegisterCompanyState();
}

class _RegisterCompanyState extends State<RegisterCompany> {
  File _image;
  List<String> staffList = new List<String>();
  String _selectStaff;

  @override
  void initState() {
    super.initState();
    loadStaff();
  }
  @override
  Widget build(BuildContext context) {
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
                      height: 290,
                      child: Column(
                        children: <Widget>[
                           //ROLE UI
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0, bottom: 5.0, left: 25.0, right: 25.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                icon: Icon(
                                  FontAwesomeIcons.scroll,
                                  color: Colors.orange,
                                ),
                                labelText: 'Your Role',
                                labelStyle: AppTextStyle.inputLabelStyle(context),
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                              ),
                            ),
                          ),

                           //DEPARTMENT UI
                          Padding(
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 25.0, right: 25.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                icon: Icon(
                                  FontAwesomeIcons.personBooth,
                                  color: Colors.orange,
                                ),
                                labelText: 'Department',
                                labelStyle: AppTextStyle.inputLabelStyle(context),
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                              ),
                            ),
                          ),

                          //NO OF SATFF UI
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0, bottom: 5.0, left: 25.0, right: 25.0),
                            child: Row(children: <Widget>[
                              Icon(FontAwesomeIcons.users, color: Colors.orange,),
                              SizedBox(width: 20.0,),
                              Container(
                                width: 200,
                                height: 50,
                                child: DropdownButton<String>(
                                elevation: 6,
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                hint: Text(
                                  "No of Staff",
                                  textAlign: TextAlign.center,
                                ),
                                value: _selectStaff,
                                onChanged: (String value) {
                                  setState(() {
                                    _selectStaff = value;
                                  });
                                  print(_selectStaff);
                                },
                                items: staffList.map((String val) {
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
                    
                            ],)
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       top: 10.0,left: 25.0, right: 25.0),
                          //   child: RaisedButton(
                          //     color: AppColor.d,
                          //     onPressed: (){
                          //       getImage();
                          //     },
                          //     child: Text('Upload company logo', style: TextStyle(color:  Colors.white),),
                          //   )
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 10.0),
                          //   child: Center(
                          //     child: _image == null
                          //         ? Text('No image selected.')
                          //         : Image.file(_image),
                          //   ),
                          // ),
                        
                        ],
                      ),
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top: 270.0),
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
                      splashColor: Colors.grey,
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          "REGISTER",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: "WorkSansBold"),
                        ),
                      ),
                      onPressed: () {
                        
                      }
                  ),
                ),
              ],
            ),
            SizedBox(height: 100.0,)
          ],
        ),
      ),
    );
  }

  loadStaff(){
    staffList.add("<  5");
    staffList.add("5 - 10");
    staffList.add("10 - 50");
    staffList.add("> 50");
  
  }

}
