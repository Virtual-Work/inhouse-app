import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtualworkng/TesterUI.dart';
import 'package:virtualworkng/core/Services/Api.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/locator.dart';
import 'package:virtualworkng/model/ListofProjects.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/AdminDasbhoardScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/AdminWithdrawalScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/DisputesScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListOfProjectsScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListofStaffsScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ReportScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffDashboard.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/ReportTabs.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/StaffDisputeScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/StaffProfilleScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/StaffReportScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/StaffWalletUI.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/util/customFunctions.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:virtualworkng/widgets/noInternet.dart';

var customF = locator<CustomFunction>();
var api = locator<Api>();
class StaffMainScreen extends StatefulWidget {
  @override
  _StaffMainScreenState createState() => _StaffMainScreenState();
}

class _StaffMainScreenState extends State<StaffMainScreen> with TickerProviderStateMixin{
  AnimationController animationController;
  Animation<double> topBarAnimation;
  List<Widget> listViews = List<Widget>();
  var scrollController = ScrollController();
  double topBarOpacity = 0.0;
  bool isSelected = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
  }


  @override
  Widget build(BuildContext context) {
  return  Scaffold(
        backgroundColor: AppColor.lightText,
        resizeToAvoidBottomPadding: false,
        body: OfflineBuilder(
            connectivityBuilder: (
                BuildContext context, ConnectivityResult connectivity,
                Widget child,) {
              final bool connected = connectivity != ConnectivityResult.none;
              return  Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                      color: connected ? Colors.white : Color(0xFFEE4400),
                      child: (connected ? switchBody()
                          : NoInternetWidgets())
                  ),
                ],
              );
            },
            child: Container()
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _selectedIndex,
          backgroundColor: AppColor.nearlyWhite,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: AppColor.thirdColor,
              inactiveColor: AppColor.orange,
            ),
            BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.wallet, color: Colors.orange,),
              title: Text('E-Wallet'),
              activeColor: AppColor.thirdColor,
              inactiveColor: AppColor.orange,
            ),
            BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.fileAlt),
              title: Text('Report'),
              activeColor: AppColor.thirdColor,
              inactiveColor: AppColor.orange,
            ),
            BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.discord),
              title: Text('Dispute'),
              activeColor: AppColor.thirdColor,
              inactiveColor: AppColor.orange,
            ),
            BottomNavyBarItem(
              icon:  Icon(FontAwesomeIcons.user),
              title: Text('Account'),
              activeColor: AppColor.thirdColor,
              inactiveColor: AppColor.orange,
            ),
          ],
        ),
  );
  }

  switchBody(){
//    HOME, E-Wallet,  Disputes,  Report, Account,
    if(_selectedIndex == 0){
      return StaffDashboard(animationController); //    HOME,
     // return TesterUI(); //    HOME,

    }else if(_selectedIndex == 1){
      return StaffWallet(animationController); //E-Wallet

    }else if(_selectedIndex == 2){ //Report
      return ReportTabs(animationController);

    }else if(_selectedIndex == 3){ //Disputes
      return StaffDisputeScreen(animationController);

    }else if(_selectedIndex == 4){
      return StaffProfileScreen(); //Account
    }
  }

}
