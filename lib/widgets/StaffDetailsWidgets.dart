import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListOfProjectsScreen.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/util/customFunctions.dart';
import 'package:virtualworkng/util/screen_size.dart';

import '../locator.dart';

var customF = locator<CustomFunction>();
class StaffDetailsWidgets extends StatefulWidget {
 final String email, firstName, lastName, pix, privilege;
 final List<dynamic> projects;

 StaffDetailsWidgets({this.email, this.firstName, this.lastName, this.pix,
 this.projects, this.privilege});

  @override
  _StaffDetailsWidgetsState createState() => _StaffDetailsWidgetsState();
}

class _StaffDetailsWidgetsState extends State<StaffDetailsWidgets> {

bool deleteprocessing = false;

  @override
  Widget build(BuildContext context) {
   // projectListView(widget.projects);
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.secondColor,
      appBar: AppBar(
        title: Center(child: Text('${widget.email}', style: AppTextStyle.headerSmaller(context),)),
        backgroundColor: AppColor.thirdColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              child: Icon(Icons.edit, color: Colors.white,),
              onTap: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Edit_Update_Profile(staffEmail: widget.email,
                        privilege: widget.privilege,
                        fName: widget.firstName,
                        lName: widget.lastName,
                       phoneN: '',
                      );});
              },
            ),
          )
        ],
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
                _media.longestSide <= 775 ? 80 : 240, context),
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
                    child:  projectListView(widget.projects)
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
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AssignProject(staffEmail: widget.email,);});
      },
      ),
    );
  }

  Widget projectListView(List projects){
   return (widget.projects == null ? Container(child: Text('No Project Available'),):
         ListView.separated(
    itemCount: projects.length,
        itemBuilder: (BuildContext context, index){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          dense: true,
          leading: Icon(FontAwesomeIcons.file),
          title: Text('${projects[index]}', style: AppTextStyle.emailheaderSmall(context),),
            trailing: SizedBox(
              height: 50,
              width: 50,
              child: GestureDetector(
                child: (deleteprocessing ?  customF.loadingWidget() :
                Icon(Icons.delete, color: Colors.red,)
                ),
                onTap: (){
                  deleteProject(projects[index]);
                },
              ),
            ),
        ),
      );

    }, separatorBuilder: (BuildContext context, int index) => Divider(
    color: Colors.black,
    )
    ));

  }

  deleteProject(String pName){
    api.deleteProjectFromSupervisor(projectName: pName, staffEmail: widget.email).then((v){
       if (v != null) {
          // print(v.documentID);
          stopLoading();
        } else {
          stopLoading();
          customF.showToast(message: 'Successfully Registered');
         Navigator.pop(context);
        }
    });
  }

 startLoading(){
    setState(() {
      deleteprocessing = true;
    });
  }

  stopLoading(){
    setState(() {
      deleteprocessing = false;
    });
  }
}

class AssignProject extends StatefulWidget {
  final staffEmail;

  AssignProject({this.staffEmail});

  @override
  _AssignProjectState createState() => _AssignProjectState();
}

class _AssignProjectState extends State<AssignProject> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Assign Project to ${widget.staffEmail} ', style: AppTextStyle.headerSmallWhite2(context),)),
            backgroundColor: AppColor.thirdColor,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: StreamBuilder(
                stream: api.getProjects(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    customF.errorWidget(snapshot.error.toString());
                  return snapshot.hasData
                      ? View(snapshot.data.documents):
                  customF.loadingWidget();
                }
            ),
          ),
        )
      ),
    );
  }

  View(List<DocumentSnapshot> documents){
   return ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 10),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: (documents.length == null ? 0 : documents.length),
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            child:  (documents.length> 0 ? GestureDetector(
              child: Container(
                  child: ListTile(
                    dense: true,
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Material(
                        elevation: 10,
                        shape: CircleBorder(),
                        shadowColor: Color(0xFF63013C), //ChangeColor(transaction[index].network).withOpacity(0.4),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColorDark,
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Icon(
                              FontAwesomeIcons.solidFile,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                        documents[index].documentID == null ? '' : documents[index].documentID,
                        style: AppTextStyle.headerSmall(context)
                    ),
                    enabled: true,
                  )
              ),
            )
                : customF.getInformationMessage('No Data Found')),
          ),
          onTap: (){
            api.addProjectToSupervisor(projectName: documents[index].documentID,
                staffEmail: widget.staffEmail).then((v){
              if (v != null) {
                // print(v.documentID);
               // stopLoading();
              } else {
             //   stopLoading();
                customF.showToast(message: 'Successfully Added');
                Navigator.pop(context);
              }
            });
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}


class Edit_Update_Profile extends StatefulWidget {
  final staffEmail, privilege, fName, lName, phoneN;

  Edit_Update_Profile({this.staffEmail, this.privilege, this.fName, this.lName, this.phoneN});

  @override
  _Edit_Update_ProfileState createState() => _Edit_Update_ProfileState();
}

class _Edit_Update_ProfileState extends State<Edit_Update_Profile> {

  TextEditingController fnameController = new TextEditingController();
  TextEditingController LnameController = new TextEditingController();
  TextEditingController phoneNoController = new TextEditingController();

  List<String> _previdleg = new List<String>();
  String _selectedPrevidleg;
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Update ${widget.staffEmail} ', style: AppTextStyle.headerSmallWhite2(context),)),
              backgroundColor: AppColor.thirdColor,
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 25, bottom: 10.0, top: 1.0, right: 10),
                      child: TextField(
                        focusNode: FocusNode(),
                        controller: fnameController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: AppColor.darkerText),
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          icon: Icon(
                            FontAwesomeIcons.user,
                            color: AppColor.thirdColor,
                          ),
                          labelText: 'FirstName',
                          hintStyle:TextStyle(color: AppColor.darkerText, fontSize: 13.0, fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(color: AppColor.dark_grey, fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, bottom: 10.0, top: 1.0, right: 10),
                      child: TextField(
                        focusNode: FocusNode(),
                        controller: LnameController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: AppColor.darkerText),
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          icon: Icon(
                            FontAwesomeIcons.user,
                            color: AppColor.thirdColor,
                          ),
                          labelText: 'LastName',
                          hintStyle:TextStyle(color: AppColor.darkerText, fontSize: 13.0, fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(color: AppColor.dark_grey, fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, bottom: 10.0, top: 1.0, right: 10),
                      child: TextField(
                        focusNode: FocusNode(),
                        controller: phoneNoController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: AppColor.darkerText),
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          icon: Icon(
                            FontAwesomeIcons.user,
                            color: AppColor.thirdColor,
                          ),
                          labelText: 'PhoneNumber',
                          hintStyle:TextStyle(color: AppColor.darkerText, fontSize: 13.0, fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(color: AppColor.dark_grey, fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 20.0, left: 20.0, right: 2.0),
                        child: Row(children: <Widget>[
                          Icon(FontAwesomeIcons.user, color: Colors.orange,),
                          SizedBox(width: 10.0,),
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
                                "Privilege ",
                                textAlign: TextAlign.center,
                              ),
                              value: _selectedPrevidleg,
                              onChanged: (String value) {
                                setState(() {
                                  _selectedPrevidleg = value;
                                });
                                print(_selectedPrevidleg);
                              },
                              items: _previdleg.map((String val) {
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
                          )
                        ],)
                    ),
                    processing ? CircularProgressIndicator(backgroundColor: AppColor.deep00,)
                        : RaisedButton(
                      child: Text("Update"),
                      splashColor: AppColor.orange,
                      elevation: 10,
                      animationDuration: Duration(seconds: 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      color: AppColor.primaryColorDark,
                      textColor: Colors.white,
                      onPressed: (){
                        updateStaff(); //Adding staff mail to the Server.
                      },
                    ),
                  ],
                ),
              )
            ),
          )
      ),
    );
  }

  @override
  void initState() {
    _selectedPrevidleg = widget.privilege;
    fnameController.text = widget.fName;
    LnameController.text = widget.lName;
    phoneNoController.text = widget.phoneN;
    add();
    super.initState();
  }

  add(){
    _previdleg.add('Staff');
    _previdleg.add('supervisor');
  }

  updateStaff(){

  api.edit_Update_Staff(fName: fnameController.text.trim(),
  lName: LnameController.text.trim(), staffEmail: widget.staffEmail,
  priviledge: _selectedPrevidleg, phoneN: phoneNoController.text.trim(),
  ).then((v){
    startLoading();
    if (v != null) {
      // print(v.documentID);
      stopLoading();
    } else {
      stopLoading();
      customF.showToast(message: 'Successfully Update');
      Navigator.pop(context);
    }
  });
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
}
