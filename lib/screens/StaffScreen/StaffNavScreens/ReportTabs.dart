import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/core/Services/Api.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/locator.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/SearchScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/StaffReportScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/ViewAllReports.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';
import 'package:virtualworkng/util/customFunctions.dart';


class ReportTabs extends StatefulWidget {
  AnimationController animationController;

  ReportTabs(this.animationController);

  @override
  _ReportTabsState createState() => _ReportTabsState();
}

class _ReportTabsState extends State<ReportTabs> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.search, color: Colors.white,),
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchScreen()
                    ));
              },
            ),
          ],
          backgroundColor: AppColor.thirdColor,
          bottom: TabBar(
              indicatorColor: AppColor.nearlyWhite,
              tabs:[
                Tab(icon: Text('Report', style: AppTextStyle.headerSmallWhite(context))),
                Tab(icon: Text('View Reports', style: AppTextStyle.headerSmallWhite(context))),
              ] ),
        ),
        body: TabBarView(
          children: <Widget>[
            StaffReportScreen(widget.animationController), //Display List of Project and click on project name to submit Report
            ViewAllReportScreen(widget.animationController), //Display List of Submitted Reports. including the pending, complete etc
          ],
        ),
      ),
    );
  }

}
