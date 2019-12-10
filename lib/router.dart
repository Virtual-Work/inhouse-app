//
import 'package:flutter/material.dart';
import 'package:virtualworkng/TesterUI.dart';
import 'package:virtualworkng/enum/constants.dart';
import 'package:virtualworkng/screens/AdminMainScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminNavScreens/ListOfProjectsScreen.dart';
import 'package:virtualworkng/screens/AdminScreen/AdminnavHomeScreen.dart';
import 'package:virtualworkng/screens/Countdown.dart';
import 'package:virtualworkng/screens/LoginScreen.dart';
import 'package:virtualworkng/screens/MenuScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/ReportScreen.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffNavScreens/StaffWalletUI.dart';
import 'package:virtualworkng/screens/StaffScreen/StaffnavigationHomeScreen.dart';
import 'package:virtualworkng/screens/Wrapper.dart';
import 'package:virtualworkng/ui/AdminRegister1.dart';
import 'package:virtualworkng/ui/AdminRegisterPage.dart';
import 'package:virtualworkng/ui/customDrawer/AdminhomeDrawer.dart';
import 'package:virtualworkng/widgets/StaffTabs.dart';
import 'screens/AdminScreen/AdminNavScreens/ListofStaffsScreen.dart';

////sending dat to next screen
////Navigator.pushNamed(context, feedRoute, arguments: 'Data from home');
////var data = settings.arguments as String;
////return MaterialPageRoute(builder: (_) => Feed(data));
//import 'package:flutter/material.dart';
////import 'package:smartchurch/enum/constants.dart';
////import 'package:booking_theater/ui/dashboardView.dart';
////import 'package:smartchurch/ui/login_Register_View.dart';
//
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
//      case onscreenRoute:
//        return MaterialPageRoute(builder: (_) => OnscreenView());

     case mainRoute:
       return MaterialPageRoute(builder: (_) => Wrapper());

//      case adminLoginRegisterRoute:  ///ADMIN DOESN"T REGISTER ON THE APP ANYMORE
//        return MaterialPageRoute(builder: (_) => AdminRegisterPage());

     case loginRoute:
       return MaterialPageRoute(builder: (_) => LoginScreen());

         case adminDashboardRoute:
        return MaterialPageRoute(builder: (_) => AdminMainScreen());

        case staffDashboardRoute:
       return MaterialPageRoute(builder: (_) => AdminRegister1());

       case TestingRoute:
       return MaterialPageRoute(builder: (_) => AdminMainScreen());

      case countdownRoute:
        return MaterialPageRoute(builder: (_) => CountDownTimer());
    }
  }
}
