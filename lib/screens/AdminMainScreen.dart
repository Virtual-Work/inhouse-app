import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualworkng/TesterUI.dart';
import 'package:virtualworkng/model/ListofProjects.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/AdminDasbhoardScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/AdminWithdrawalScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/DisputesScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListOfProjectsScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListofStaffsScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ReportScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/TitleView.dart';
import 'package:virtualworkng/screens/StaffScreen/SubmitReportUI.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/widgets/ReportCardWidgets.dart';
import 'package:virtualworkng/widgets/StaffTabs.dart';
import 'package:virtualworkng/widgets/StaffWalletView.dart';
import 'package:virtualworkng/widgets/TransactionCard.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:virtualworkng/widgets/noInternet.dart';
class AdminMainScreen extends StatefulWidget {
  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> with TickerProviderStateMixin{
  AnimationController animationController;
  Animation<double> topBarAnimation;

  // var customFunction = locator<CustomFunction>();
  List<Widget> listViews = List<Widget>();
  var scrollController = ScrollController();
  double topBarOpacity = 0.0;
  bool isSelected = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    super.initState();
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
                      child: (connected ? switchBody() : NoInternetWidgets())
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
              icon: Icon(FontAwesomeIcons.user, color: Colors.orange,),
              title: Text('Staff'),
              activeColor: AppColor.thirdColor,
              inactiveColor: AppColor.orange,
            ),
            BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.laugh),
              title: Text('Disputes'),
              activeColor: AppColor.thirdColor,
              inactiveColor: AppColor.orange,
            ),
            BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.fileImage),
              title: Text('Projects'),
              activeColor: AppColor.thirdColor,
              inactiveColor: AppColor.orange,
            ),
            BottomNavyBarItem(
              icon:  Icon(CommunityMaterialIcons.reply),
              title: Text('Reports'),
              activeColor: AppColor.thirdColor,
              inactiveColor: AppColor.orange,
            ),
          ],
        ),
  );
  }

  switchBody(){
//    HOME, Users,  Disputes,  Withdrawals, Reports,s
    if(_selectedIndex == 0){
      return AdminDashboard(animationController); //    HOME,

    }else if(_selectedIndex == 1){
     // return ListofStaffScreen(); //Users,
      return StaffTabs(); //Users,  List of staffs Screen

    }else if(_selectedIndex == 2){ //Disputes Screen
      return DisputeScreen();

    }else if(_selectedIndex == 3){ //Withdrawals Screen
      return ListOfProjectScreen();

    }else if(_selectedIndex == 4){
      return ReportScreen(); //Report Screen
      //return TesterUI(); //Report Screen
    }
  }
}
