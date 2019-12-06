import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListOfProjectsScreen.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/util/screen_size.dart';

class StaffDetailsWidgets extends StatefulWidget {
 final String email, firstName, lastName, pix, privilege;
 final List<dynamic> projects;

 StaffDetailsWidgets({this.email, this.firstName, this.lastName, this.pix,
 this.projects, this.privilege});

  @override
  _StaffDetailsWidgetsState createState() => _StaffDetailsWidgetsState();
}

class _StaffDetailsWidgetsState extends State<StaffDetailsWidgets> {

  @override
  Widget build(BuildContext context) {
   // projectListView(widget.projects);
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.secondColor,
      appBar: AppBar(
        title: Center(child: Text('${widget.email} Details', style: AppTextStyle.headerSmall2(context),)),
        backgroundColor: AppColor.thirdColor,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AvatarGlow(
                      startDelay: Duration(milliseconds: 1000),
                      glowColor: AppColor.white,
                      endRadius: 60.0,
                      duration: Duration(milliseconds: 2000),
                      repeat: true,
                      showTwoGlows: true,
                      repeatPauseDuration: Duration(milliseconds: 100),
                      child: CircleAvatar(
                        backgroundColor:Colors.orange ,
                        child: Image.asset('assets/images/img/userimage.jpg',height: 60, fit: BoxFit.cover,),
                        radius: 50.0,
                      ),
                      shape: BoxShape.circle,
                      animate: true,
                      curve: Curves.fastOutSlowIn,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Dialog(
                          elevation: 10,
                          shape: OutlineInputBorder(),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(left:16.0, right: 16.0, bottom: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Divider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0),
                                            child:Text((widget.email != null ? "Email: ${widget.email}" : ''),
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0),
                                            child:  Text(widget.firstName != null ? "Firstname: ${widget.firstName}" : '',
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
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0),
                                            child: Text(widget.lastName != null ? "Last Name: ${widget.lastName}" : '',
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
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0),
                                            child: Text(widget.privilege != null ? 'Priviledge : ${widget.privilege}' : '',
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
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0),
                                            child: Text('Sometime:',
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

                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0),
                                            child: Text('Phone No',
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
                                      SizedBox(height: 20.0),
                                    ],
                                  )
                              ),
                            ],
                          )
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text('Projects', style: AppTextStyle.headerSmall2(context),)
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            height: screenAwareSize(
                _media.longestSide <= 775 ? 80 : 200, context),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                // ignore: missing_return
                overscroll.disallowGlow();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Dialog(
                    elevation: 10,
                    shape: OutlineInputBorder(),
                    child: projectListView(widget.projects)
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.d,
        child: Icon(Icons.add, color: AppColor.white,
          size: 19,), onPressed: () {
        _addProject(context);
      },
      ),
    );
  }
  _addProject(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context,state){
                return AddProject(stateSetter: state, showSupervisorWidget: false, supervisorEmail: widget.email,); //should i show a place to add supervisor mail;
              });
        });
  }

  Widget projectListView(List projects){
//   for(int i = 0; i < projects.length; i++){
//     print(projects[i]);
//   }
    return ListView.builder(
        itemCount: projects.length,
        itemBuilder: (BuildContext context, index){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('${projects[index]}', style: AppTextStyle.emailheaderSmall(context),),
      );
    });
  }

}