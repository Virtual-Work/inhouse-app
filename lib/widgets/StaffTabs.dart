import 'package:flutter/material.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListofStaffsScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/SearchScreen.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/style/AppTextStyle.dart';

class StaffTabs extends StatefulWidget {
  @override
  _StaffTabsState createState() => _StaffTabsState();
}

class _StaffTabsState extends State<StaffTabs> {
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
            Tab(icon: Text('Staffs', style: AppTextStyle.headerSmallWhite(context))),
            Tab(icon: Text('Archive Staffs', style: AppTextStyle.headerSmallWhite(context))),
          ] ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListofStaffScreen(),
            ListofStaffScreen(),
          ],
        ),
      ),
    );
  }
}
