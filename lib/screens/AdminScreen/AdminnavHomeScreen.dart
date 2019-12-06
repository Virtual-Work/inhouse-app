 import 'package:flutter/material.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/AdminHomeScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/DisputesScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ReportScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListofStaffsScreen.dart';
 import 'package:virtualworkng/style/AppColor.dart';
import 'package:virtualworkng/ui/customDrawer/ADMINdrawerUserController.dart';
import 'package:virtualworkng/ui/customDrawer/AdminhomeDrawer.dart';

 class AdminNavigationHomeScreen extends StatefulWidget {
   @override
   _AdminNavigationHomeScreenState createState() => _AdminNavigationHomeScreenState();
 }

 class _AdminNavigationHomeScreenState extends State<AdminNavigationHomeScreen> {
   Widget screenView;
   DrawerIndex drawerIndex;
   AnimationController sliderAnimationController;

   @override
   void initState() {
     drawerIndex = DrawerIndex.HOME;
     screenView = AdminHomePage();
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
           body: d(drawerIndex),
         ),
       ),
     );
   }

   d(drawerIndex){
     if(drawerIndex == DrawerIndex.HOME){
       return ADMINDrawerUserController(
         screenIndex: DrawerIndex.HOME,
         drawerWidth: MediaQuery.of(context).size.width * 0.75,
         animationController: (AnimationController animationController) {
           sliderAnimationController = animationController;
         },
//         onDrawerCall: (DrawerIndex drawerIndexdata) {
//           changeIndex(drawerIndexdata);
//         },
         screenView: AdminHomePage(),
       );

     }else if(drawerIndex == DrawerIndex.Users){
       return ADMINDrawerUserController(
         screenIndex: DrawerIndex.Users,
         drawerWidth: MediaQuery.of(context).size.width * 0.75,
         animationController: (AnimationController animationController) {
           sliderAnimationController = animationController;
         },
//         onDrawerCall: (DrawerIndex drawerIndexdata) {
//           changeIndex(drawerIndexdata);
//         },
         screenView: ListofStaffScreen(),
       );

     }else if(drawerIndex == DrawerIndex.Disputes){
       return ADMINDrawerUserController(
         screenIndex: DrawerIndex.Disputes,
         drawerWidth: MediaQuery.of(context).size.width * 0.75,
         animationController: (AnimationController animationController) {
           sliderAnimationController = animationController;
         },
//         onDrawerCall: (DrawerIndex drawerIndexdata) {
//           changeIndex(drawerIndexdata);
//         },
         screenView: DisputeScreen(),
       );
     }


   }

   void changeIndex(DrawerIndex drawerIndexdata) {
     if (drawerIndex != drawerIndexdata) {
       drawerIndex = drawerIndexdata;
       if (drawerIndex == DrawerIndex.HOME) {
         setState(() {
           screenView = AdminHomePage();
           drawerIndex = DrawerIndex.HOME;
         });
       } else if (drawerIndex == DrawerIndex.Users) {
         setState(() {
           screenView = ListofStaffScreen();
           drawerIndex = DrawerIndex.Users;
         });
       } else if (drawerIndex == DrawerIndex.Disputes) {
         setState(() {
           screenView = DisputeScreen();
           drawerIndex = DrawerIndex.Disputes;
         });
       } else if (drawerIndex == DrawerIndex.Withdrawals) {
         setState(() {
           screenView = DisputeScreen();
           drawerIndex = DrawerIndex.Withdrawals;
         });
       } else if (drawerIndex == DrawerIndex.Reports) {
         setState(() {
           screenView = ReportScreen();
           drawerIndex = DrawerIndex.Reports;
         });
       } else {
         //do in your way......
       }
     }
   }
 }
