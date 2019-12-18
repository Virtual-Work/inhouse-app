import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:virtualworkng/core/Services/Api.dart';
import 'package:virtualworkng/locator.dart';
import 'package:virtualworkng/model/ListofProjects.dart';
import 'package:virtualworkng/screens/StaffScreen/SubmitReportUI.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/util/customFunctions.dart';
import 'package:virtualworkng/widgets/ListOfProjectWidgets.dart';

var customF = locator<CustomFunction>();
var api = locator<Api>();

class ListOfProjectScreen extends StatefulWidget {
  @override
  _ListOfProjectScreenState createState() => _ListOfProjectScreenState();
}

class _ListOfProjectScreenState extends State<ListOfProjectScreen> with TickerProviderStateMixin{
  AnimationController animationController;
  Animation<double> topBarAnimation;

  // var customFunction = locator<CustomFunction>();
  List<Widget> listViews = List<Widget>();
  var scrollController = ScrollController();
  double topBarOpacity = 0.0;
  bool isSelected = false;


  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    topBarAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    var count = 5;
    listViews.add(
        SizedBox(height: 10,)
    );
    listViews.add(
      ListOfProjectCards(
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve: Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: animationController,
      ),
    );
    listViews.add(
        SizedBox(height: 100,)
    );
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.lightText,
      body: StreamProvider<QuerySnapshot>.value(
        value: api.getProjects(),
        child: Builder(
            builder: (context){
              var snapshot = Provider.of<QuerySnapshot>(context);
              if(snapshot == null){
                return customF.loadingWidget();
              }else{
                return Stack(
                  children: <Widget>[
                    getMainListViewUI(),
                    getAppBarUI(),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                );
              }
            }
        ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.thirdColor,
        child: Icon(
          Icons.add,
          size: 30.0,
          color: Colors.white,
        ),
        onPressed: (){
          _addProject(context);
        },
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
              //bottom: 19 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: new Transform(
                transform: new Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColorDark.withOpacity(topBarOpacity),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppColor.primaryColorDark.withOpacity(0.4 * topBarOpacity),
                          offset: Offset(1.1, 1.1), blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Projects",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppColor.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: AppColor.nearlyBlack,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                                onTap: () {},
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: AppColor.grey,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 1,
                                right: 1,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.fileImage,color: AppColor.grey,)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                                onTap: () {},
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: AppColor.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  _addProject(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context,state){
                return AddProject(stateSetter: state, showSupervisorWidget: true,); //
                // should i show a place to add supervisor mail;
              });
        });
  }

}

class AddProject extends StatefulWidget {
  final StateSetter stateSetter;
  final showSupervisorWidget;
  final String supervisorEmail;

  AddProject({this.stateSetter, this.showSupervisorWidget, this.supervisorEmail});

  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  List<String> _supervisors = new List<String>();
  String _selectedSepervisors;
  bool processing = false;
  TextEditingController projectCommentController = TextEditingController();
  TextEditingController projectTitleController = TextEditingController();
  String formattedDate;

  @override
  void initState() {
    super.initState();
    todayDate();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.getListOfStaffsFuture(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError)
          customF.errorWidget(snapshot.error.toString());
        return snapshot.hasData
            ? SingleChildScrollView(
           child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: <Widget>[
                addToList(snapshot), //Adding toList
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  color: AppColor.primaryColorDark,
                  child: Center(child: Text('Add Project', style: AppTextStyle.headerSmall2(context),)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: TextField(
                    controller: projectTitleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Project Title',
                      labelStyle: AppTextStyle.inputLabelStyle(context),
                      hintStyle: TextStyle(
                          fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                    ),

                  ),
                ),
                Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: projectCommentController,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Comment',
                  labelStyle: AppTextStyle.inputLabelStyle(context),
                  hintStyle: TextStyle(
                      fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                ),

              ),
            ),
                SizedBox(height: 10.0),
                (widget.showSupervisorWidget ? Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: FindDropdown(
                    items: _supervisors,
                    label: "Select Supervisor",
                    onChanged:(value){
                      _selectedSepervisors = value;
                    },
                    selectedItem: 'staff@virtualwork.ng',
                    validate: (String item) {
                      if (item == null)
                        return "Required field";
                      else if (item == "Adobe")
                        return "Invalid item";
                      else
                        return null;
                    },
                  ),
                ) : SizedBox()),
                processing ? CircularProgressIndicator(backgroundColor: AppColor.deep00,) : RaisedButton(
                  child: Text("Add Project"),
                  splashColor: AppColor.orange,
                  elevation: 10,
                  animationDuration: Duration(seconds: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  color: AppColor.primaryColorDark,
                  textColor: Colors.white,
                  onPressed: (){
                    addProjectToServer();
                  },
                ),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ) : //(snapshot.data.documents):
        customF.loadingWidget();
      }
    );
  }

  startLoading(){
    widget.stateSetter(() {
      processing = true;
    });
  }

  stopLoading(){
    widget.stateSetter(() {
      processing = false;
    });
  }

  //Fetching Staff that container Supervisor privilege and display as Dropdown
  addToList( AsyncSnapshot<QuerySnapshot> snapshot){
    if(_supervisors != null){
      _supervisors.clear();
    }
   // print("************ Emails ***********");
  for(var doc in snapshot.data.documents){
    if(doc.data['privilege'] == 'Staff'){ //If priviledge is Staff don't display the Email

    }else{
     // print('${doc.data['Email']} = ${doc.data['privilege']}');
      _supervisors.add(doc.documentID);
    }
  }
  return SizedBox();
  }

  addProjectToServer(){
    String pComment = projectCommentController.text.trim();
    String pTitle = projectTitleController.text.trim();
    String supervisor = widget.showSupervisorWidget ? _selectedSepervisors : widget.supervisorEmail;

    if(pComment.isEmpty|| pTitle.isEmpty){
      customF.showToast(message: 'Empty field detected');
    }else{
      startLoading();
      api.addProject(comment: pComment, projectTitle: pTitle, supervisor: supervisor, createdDate: formattedDate).then((v) {
        if (v != null) {
          // print(v.documentID);
          stopLoading();
        } else {
          stopLoading();
          customF.showToast(message: 'Project Successfully Added');
          Navigator.pop(context);
        }
      });
    }

  }

  todayDate(){
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    formattedDate = formatter.format(now);
  }

}