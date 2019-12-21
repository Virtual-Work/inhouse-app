
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
import 'package:virtualworkng/util/screen_size.dart';

//******************************************************************************************************************
//*******************Admin Report Widget**********************************
///**********************************************************************************************************************
class AdminReportWidgets extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const AdminReportWidgets({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _AdminReportWidgetsState createState() => _AdminReportWidgetsState();
}

class _AdminReportWidgetsState extends State<AdminReportWidgets> {

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
                var count = snapshot.documents.length;
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                return ReportView(
                  projectName:snapshot.documents[index].documentID,
                  animation: animation,
                  timeFrom: (snapshot.documents[index].data['Time from'] == null ? " " : snapshot.documents[index].data['Time from']),
                  timeTo:  (snapshot.documents[index].data['Time To'] == null ? '' : snapshot.documents[index].data['Time To']),
                  tasks: snapshot.documents[index].data['Tasks'],
                  status: snapshot.documents[index].data['status'],
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

class ReportView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final String projectName, timeFrom, timeTo;
  final Map<dynamic, dynamic> tasks;
  final int status;

  ReportView({
    Key key,
    this.animationController,
    this.animation,
    this.timeFrom,
    this.timeTo,
    this.projectName,
    this.tasks,
    this.status
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
                            height: 40,
                            width: 40,
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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ReportDetailsView(
                          projectName: projectName,
                          timeFrom: timeFrom,
                          timeTo: timeTo,
                          tasks: tasks,
                          status: status,
                        );});
                },
              )
          ),
        );
      },
    );
  }


}

class ReportDetailsView extends StatefulWidget {
  final String projectName, timeFrom, timeTo;
  final Map<dynamic, dynamic> tasks;
  final int status;

  ReportDetailsView({this.projectName, this.timeFrom, this.timeTo, this.tasks, this.status});

  @override
  _ReportDetailsViewState createState() => _ReportDetailsViewState();
}

class _ReportDetailsViewState extends State<ReportDetailsView> {
  bool processing = false;
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.thirdColor,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
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
                                            child:Text((widget.projectName != null ? "Project Name: ${widget.projectName}" : ''),
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
                                            child:  Text(widget.timeFrom != null ? "From Time: ${widget.timeFrom}" : '',
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
                                            child: Text(widget.timeTo != null ? "To Time: ${widget.timeTo}" : '',
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
                                              child: Text(
                                                'Status: ${customF.reportStatus(widget.status)}',
                                                style: TextStyle(
                                                    inherit: true,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0,
                                                    color: Colors.green),
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.center,
                                              )
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
                child: Text('Tasks Worked On', style: AppTextStyle.headerSmall2(context),)
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
                    child:  taskListView(widget.tasks)
                ),
              ),
            ),
          ),
          (processing ? customF.loadingWidgetInWhite() : _getActionButtons()),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
            child: Container(
                child: new RaisedButton(
                  child: new Text("Back", style: AppTextStyle.h2(context),),
                  textColor: Colors.white,
                  color: AppColor.d,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                )),
          ),
        ],
      ),
    );
  }
  Widget taskListView(Map tasks){
    return (widget.tasks == null ? Container(child: Text('No Task Available'),):
    ListView.separated(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              dense: true,
              leading: Icon(FontAwesomeIcons.file),
              title: Text('${tasks[index]}', style: AppTextStyle.emailheaderSmall(context),),
            ),
          );

        }, separatorBuilder: (BuildContext context, int index) => Divider(
      color: Colors.black,
    )
    ));

  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
      child:  Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Approve"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      letMeDecides(value: true);//Yea, I approve this Report
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("disapprove"),
                    textColor: Colors.white,
                    color: Colors.redAccent,
                    onPressed: () {
                      letMeDecides(value: false);//No, I don't approve this Report
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  letMeDecides({bool value}){
    startLoading();
    api.approveReportOf(approve: value).then((v){
      startLoading();
      if (v != null) {
        // print(v.documentID);
        stopLoading();
      } else {
        stopLoading();
        customF.showToast(message: 'Completely Done!');
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



