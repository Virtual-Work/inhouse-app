import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_dialogs/single_choice_confirmation_dialog.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:virtualworkng/model/StaffReportModel.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListOfProjectsScreen.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/util/screen_size.dart';
import 'package:virtualworkng/widgets/deleteProjectDialog.dart';

class ListOfProjectCards extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  // final formatAmounts = new NumberFormat("#,##0.00", "en_US");

  const ListOfProjectCards({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ListOfProjectCardsState createState() => _ListOfProjectCardsState();
}

class _ListOfProjectCardsState extends State<ListOfProjectCards> {
  final formatAmounts = new NumberFormat("#,##0.00", "en_US");
  String myStatus = '';
  final List<String> _options = [
  'Assign Project to Supervisor', 'View Project Details', 'Edit Project'];
  String _none = "None";
  @override
  Widget build(BuildContext context) {
       final snapshot = Provider.of<QuerySnapshot>(context);

    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 10),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: (snapshot.documents.length == null ? 0 : snapshot.documents.length),
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    child:  (snapshot.documents.length> 0 ? GestureDetector(
                      child: Container(
                          child: ListTile(
                            dense: true,
                            trailing: GestureDetector(child: Icon(Icons.delete, color: Colors.red,),
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return deleteProjectDialog(projectName: snapshot.documents[index].documentID.toString(),);
                                    });
                              },),
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
                              snapshot.documents[index].documentID == null ? '' : snapshot.documents[index].documentID,
                              style: AppTextStyle.headerSmall3(context)
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(snapshot.documents[index].data['DateCreated'] == null ? ''
                                      : 'Created : ${snapshot.documents[index].data['DateCreated']}',
                                      style: TextStyle(
                                          inherit: true,
                                          fontSize: 10.0,
                                          color: Colors.black45)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            enabled: true,
                          )
                      ),
                    )
                        : customF.getInformationMessage('No Latest Transaction')),
                  ),
                  onTap: (){
                    _openOptionDialog(index, snapshot);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
        );
      },
    );
  }

  Color ChangeColor(bool status) {

    switch (status) {
      case true:
        return Color(0xFF006E52);
        break;

      case false:
        return Color(0xFFED1B24);
        break;

      default:
        return Colors.purpleAccent;
    }
  }

  Icon checkIcon(bool status) {
    switch (status) {
      case true:
        return  Icon(
          Icons.done_all,
          size: 22.0,
          color: Color(0xFF006E52),
        );
        break;

      case false:
        return  Icon(
          Icons.error,
          size: 22.0,
          color: Color(0xFFED1B24),
        );
        break;

      default:
        return Icon(
          Icons.report,
          size: 22.0,
          color: AppColor.primaryColorDark,
        );
    }
  }

  String checkString(bool status) {
    switch (status) {
      case false:
        return 'Pending';
        break;

      case true:
        return  'Complete';
        break;

      default:
        return '';
    }
  }

  Widget getStatusWidget (bool status){
    if(status){ //If status is true
      return Icon(
        Icons.check,
        size: 22.0,
        color: Colors.green,
      );

    }else if(!status){ //If status is false
      return Icon(
        Icons.error_outline,
        size: 22.0,
        color: Colors.redAccent,
      );
    }
  }

  _openOptionDialog(int index, QuerySnapshot snapshot) {
    showDialog(
        context: context,
        builder: (context) =>  SingleChoiceConfirmationDialog<String>(
            title: Text('Select Option'),
            initialValue: _none,
            items: _options,
            onSelected: (value){
              //If it is Selected, Run this.
              _onSelected_submitted(value, index, snapshot);
            },
            //If it is Submitted, Run this.
            onSubmitted: (value){
              _onSelected_submitted(value, index, snapshot);
    }));
  }

  void _onSelected_submitted(String value, int index, QuerySnapshot snapshot) {
    if(value == 'Assign Project to Supervisor'){
      //I want to Edit a project... the second line code works for 2 action
      //1 is for Assign Project while Second is for Editing Project
      /// So now, Do no 1 Action
      _assingProject(context: context, pName: snapshot.documents[index].documentID, iWant: false, comment:  null);

    }else if(value == 'Edit Project'){
      //I want to Edit a project... the second line code works for 2 action
      //1 is for Assign Project while Second is for Editing Project
      /// So now, Do no 2 Action
      _assingProject(context: context, pName: snapshot.documents[index].documentID,
          iWant: true, comment: snapshot.documents[index].data['Comment']);

    }else{
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ViewProjectDetails(
              projectName: snapshot.documents[index].documentID,
              title:snapshot.documents[index].data['Title'],
              status: snapshot.documents[index].data['status'],
              supervisors: snapshot.documents[index].data['Supervisors'],
            );});
    }
  }

  _assingProject({BuildContext context, String pName, bool iWant, String comment}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context,state){
                return AssignProject(stateSetter: state, projectName: pName, iWantToEditProject: iWant,
                comment: comment,); //
                // should i show a place to add supervisor mail;
              });
        });
  }
}

class AssignProject extends StatefulWidget {
      String projectName;
      final StateSetter stateSetter;
      bool iWantToEditProject;
      String comment;

  AssignProject({this.projectName, this.stateSetter, this.iWantToEditProject, this.comment});

  @override
  _AssignProjectState createState() => _AssignProjectState();
}

class _AssignProjectState extends State<AssignProject> {
  bool processing = false;
  List<String> _supervisors = new List<String>();
  String _selectedSepervisors;
  TextEditingController projectTitleController = TextEditingController();
  TextEditingController projectCommentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.projectName);
    projectTitleController.text = widget.projectName;

    if(widget.comment != null){
      projectCommentController.text = widget.comment;
    }
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
                    child: (widget.iWantToEditProject ? Center(child: Text('Edit Project', style: AppTextStyle.headerSmall2(context),))
                    : Center(child: Text('Assign Project', style: AppTextStyle.headerSmall2(context),)))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextField(
                      controller: projectTitleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Project Title',
                        enabled: (widget.iWantToEditProject ? true : false),
                        labelStyle: AppTextStyle.inputLabelStyle(context),
                        hintStyle: TextStyle(
                            fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                      ),

                    ),
                  ),
                  SizedBox(height: 10.0),
                  (widget.iWantToEditProject ? Padding(
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
                  ) :
                      Container()),
                  (widget.iWantToEditProject ? Container() : Padding(
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
                  )),
                  SizedBox(height: 30.0),
                  processing ? customF.loadingWidget() :
                  (widget.iWantToEditProject ?  RaisedButton(
                    child: Text("Update Project"),
                    splashColor: AppColor.orange,
                    elevation: 10,
                    animationDuration: Duration(seconds: 5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: AppColor.primaryColorDark,
                    textColor: Colors.white,
                    onPressed: (){
                      updateProject();
                    },
                  ) :
                  RaisedButton(
                    child: Text("Assign Project"),
                    splashColor: AppColor.orange,
                    elevation: 10,
                    animationDuration: Duration(seconds: 5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: AppColor.primaryColorDark,
                    textColor: Colors.white,
                    onPressed: (){
                      assignProjectToSupervisor();
                    },
                  )),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ) : //(snapshot.data.documents):
          customF.loadingWidget();
        }
    );
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

  assignProjectToSupervisor(){
    String pTitle = projectTitleController.text.trim();
    String supervisor =  _selectedSepervisors;

    if(_selectedSepervisors.isEmpty){
      customF.showToast(message: 'Please choose a Supervisor');
    }else{
      startLoading();
      api.assignProjectToStaff(projectTitle: pTitle,
          supervisor: supervisor).then((v) {
        if (v != null) {
          // print(v.documentID);
          stopLoading();
        } else {
          stopLoading();
          customF.showToast(message: 'Project Successfully Assigned');
          Navigator.pop(context);
        }
      });
    }

  }

  updateProject(){
    String pComment = projectCommentController.text.trim();
    String pTitle = projectTitleController.text.trim();

    if(pComment.isEmpty|| pTitle.isEmpty) {
      customF.showToast(message: 'Empty field detected');
    }else{
      startLoading();
      api.editProject(comment: pComment, projectName: widget.projectName, newTitle: pTitle).then((v) {
        if (v != null) {
          // print(v.documentID);
          stopLoading();
        } else {
          stopLoading();
          customF.showToast(message: 'Project Successfully Update');
          Navigator.pop(context);
        }
      });
    }
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
}

class ViewProjectDetails extends StatefulWidget {
  String title, status, projectName;
  List supervisors;

  ViewProjectDetails({this.projectName, this.title, this.status, this.supervisors});

  @override
  _ViewProjectDetailsState createState() => _ViewProjectDetailsState();
}

class _ViewProjectDetailsState extends State<ViewProjectDetails> {

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Center(
      child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Scaffold(
            appBar: AppBar(
              title: Center(child: Text('${widget.title} Details', style: AppTextStyle.headerSmallWhite2(context),)),
              backgroundColor: AppColor.thirdColor,
            ),
            body: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 1, right: 10),
                child:  Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text('Supervisor(s)', style: AppTextStyle.headerSmall3(context),)
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1, top: 10),
                      height: screenAwareSize(
                          _media.longestSide <= 775 ? 80 : 240, context),
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          // ignore: missing_return
                          overscroll.disallowGlow();
                        },
                        child: ListView.separated(
                            itemCount: widget.supervisors.length == null ? 0 : widget.supervisors.length,
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemBuilder: (BuildContext context, index){
                              return ListTile(
                                dense: true,
                                trailing: GestureDetector(child: Icon(Icons.delete, color: Colors.red,),
                                  onTap: (){
                                    removeSupervisor(widget.projectName, widget.supervisors[index]);
                                  },),
                                title: Text(
                                    widget.supervisors[index] == null ? '' : widget.supervisors[index],
                                    style: AppTextStyle.headerSmall3_1(context)
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Tap delete to remove supervisor',
                                          style: TextStyle(
                                              inherit: true,
                                              fontSize: 10.0,
                                              color: Colors.black45)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                leading: Material(
                                  elevation: 10,
                                  shape: CircleBorder(),
                                  shadowColor: Color(0xFF63013C), //ChangeColor(transaction[index].network).withOpacity(0.4),
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: AppColor.primaryColorDark,
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Center(child: Text(index.toString(), style: AppTextStyle.headerSmaller(context),))
                                    ),
                                  ),
                                ),
                                enabled: true,
                              );
                            }),
                      ),

                    )
                  ],

                ),
                )
            ),
          )
      );
  }

  removeSupervisor(String pName, supervisorEmail) async {
    api.removeSupervisorFromProject(projectName: pName, staffEmail: supervisorEmail).then((v){
      if (v != null) {

      } else {
        customF.showToast(message: '$supervisorEmail Successfully Removed');
        Navigator.pop(context);
      }
    });

  }
}