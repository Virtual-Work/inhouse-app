
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_dialogs/single_choice_confirmation_dialog.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/model/StaffReportModel.dart';
import 'package:virtualworkng/screens/StaffScreen/SubmitReportUI.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';

//******************************************************************************************************************
//*******************Report UI or Widget**********************************
///**********************************************************************************************************************
class ReportCardWidget extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const ReportCardWidget({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _ReportCardWidgetState createState() => _ReportCardWidgetState();
}

class _ReportCardWidgetState extends State<ReportCardWidget> {
List<dynamic> projects;
  String myStatus = '';


  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);
    projects = snapshot.data['Projects'];
    if(projects.isEmpty){
      return customF.loadingWidget();
    }else{
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
                itemCount: (projects == null ? 0 : projects.length),
                itemBuilder: (context, index) {
                  var count = projects.length;
                  var animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: widget.animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  return ReportView(
                    projectName:projects[index],
                    animation: animation,
                    animationController: widget.animationController,
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
  }
}

class ReportView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final String projectName;
   List<String> _supervisorOptions = [
    'Assign Project to a Staff', 'Submit your Report for this Project'];
  String _none = "None";

   ReportView({
    Key key,
    this.animationController,
    this.animation,
    this.projectName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: GestureDetector(
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
                        projectName == null ? '' : projectName,
                        style: AppTextStyle.headerSmall3(context)
                    ),
                    enabled: true,
                  )
              ),
              onTap: (){
                action(projectN: projectName, context: context);
              },
            )
          ),
        );
      },
    );
  }

  action({String projectN, BuildContext context})async{
    //Firstly check if this User is a supervisor or a staff,
 final SharedPreferences prefs = await SharedPreferences.getInstance();
 String checkPrivilege = prefs.get(pref_privilege);

    if(checkPrivilege == 'supervisor'){
      //If it's a supervisor,
      _openSupervisorDialog(projectN: projectN, context: context);
    }else{
      //Go to Submit Report UI
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => SubmitReportUI(projectSelected: projectName),
          ),
        );
    }
  }

  _openSupervisorDialog({String projectN, BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) =>  SingleChoiceConfirmationDialog<String>(
            title: Text('Select Option'),
            initialValue: _none,
            items: _supervisorOptions,
            //If it is Submitted, Run this.
            onSubmitted: (value){
              if(value == 'Assign Project to a Staff'){
                _assingProject(context: context, pName: projectN);

              }else if(value == 'Submit your Report for this Project'){
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => SubmitReportUI(projectSelected: projectName),
                  ),
                );
              }
            }));
  }

  _assingProject({BuildContext context, String pName}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context,state){
                return AssignProject(stateSetter: state, projectName: pName,); //
                // should i show a place to add supervisor mail;
              });
        });
  }
}
class AssignProject extends StatefulWidget {
  String projectName;
  final StateSetter stateSetter;


  AssignProject({this.projectName, this.stateSetter});

  @override
  _AssignProjectState createState() => _AssignProjectState();
}

class _AssignProjectState extends State<AssignProject> {
  bool processing = false;
  List<String> _supervisors = new List<String>();
  String _selectedSepervisors;
  TextEditingController projectTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.projectName);
    projectTitleController.text = widget.projectName;

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
                      child: Center(child: Text('Assign Project to Staff', style: AppTextStyle.headerSmall2(context),))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextField(
                      controller: projectTitleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Project Title',
                        enabled: false,
                        labelStyle: AppTextStyle.inputLabelStyle(context),
                        hintStyle: TextStyle(
                            fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
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
                  ),
                  SizedBox(height: 30.0),
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

  //Fetching Staff and display as Dropdown
  addToList( AsyncSnapshot<QuerySnapshot> snapshot){
    if(_supervisors != null){
      _supervisors.clear();
    }
    for(var doc in snapshot.data.documents){
      _supervisors.add(doc.documentID);
    }
    return SizedBox();
  }

  assignProjectToSupervisor(){
    String pTitle = projectTitleController.text.trim();
    String staff =  _selectedSepervisors;

    if(_selectedSepervisors.isEmpty){
      customF.showToast(message: 'Please choose a Staff');
    }else{
      //Assign Project to a Staff
      startLoading();
      api.assignProjectToStaff(projectTitle: pTitle,
          supervisor: staff).then((v) {
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