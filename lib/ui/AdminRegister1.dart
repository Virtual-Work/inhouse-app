import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';

class AdminRegister1 extends StatefulWidget {
  @override
  _AdminRegister1State createState() => _AdminRegister1State();
}

class _AdminRegister1State extends State<AdminRegister1> {
List<String> genderList = new List<String>();
  String _selectgender;

  @override
  void initState() {
    super.initState();
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
                    height: 330,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
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
                                FontAwesomeIcons.user,
                                color: Colors.orange,
                              ),
                              labelText: 'Full Name',
                              labelStyle: AppTextStyle.inputLabelStyle(context),
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
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
                                FontAwesomeIcons.envelope,
                                color: Colors.orange,
                              ),
                              labelText: 'Email',
                              labelStyle: AppTextStyle.inputLabelStyle(context),
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              icon: GestureDetector(
                                child: Icon(
                                  FontAwesomeIcons.lock,
                                  color: Colors.orange,
                                ),
                              ),
                              labelText: 'Password',
                              labelStyle: AppTextStyle.inputLabelStyle(context),
                              hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0, ),
                              suffixIcon: GestureDetector(
                                child: Icon(
                                  FontAwesomeIcons.eye,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
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
              Container(
                margin: EdgeInsets.only(top: 300.0),
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
                        "PROCESS",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
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

}
