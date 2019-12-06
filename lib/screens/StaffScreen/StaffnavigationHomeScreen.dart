import 'package:flutter/material.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/StaffDisputeScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/StaffProfilleScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/ReportScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/homeScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/inviteFriendScreen.dart';
import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/ui/customDrawer/drawerUserController.dart';
import 'package:virtualworkng/ui/customDrawer/StaffhomeDrawer.dart';
import 'package:virtualworkng/ui/testSteper.dart';

class StaffnavigationHomeScreen extends StatefulWidget {
  @override
  _StaffnavigationHomeScreenState createState() => _StaffnavigationHomeScreenState();
}

class _StaffnavigationHomeScreenState extends State<StaffnavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;
  AnimationController sliderAnimationController;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColor.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            animationController: (AnimationController animationController) {
              sliderAnimationController = animationController;
            },
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.E_WALLET) {
        setState(() {
          screenView = ReportScreen();
        });
      } else if (drawerIndex == DrawerIndex.REPORT) {
        setState(() {
          screenView = InviteFriend();
        });
      } else if (drawerIndex == DrawerIndex.SETTINGS) {
        setState(() {
          screenView = StaffProfileScreen();

        });
      } else if (drawerIndex == DrawerIndex.DISPUTE) {
        setState(() {
          screenView = DisputeScreen();
          //screenView = Test();
        });
      } else {
        //do in your way......
      }
    }
  }
}
